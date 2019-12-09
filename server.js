'use strict';
const MandelClient = require('./mandelClient');
const protobuf = require("protobufjs");
const morgan = require('morgan');
const express = require('express');

// GET IP BEGIN
const Compute = require('@google-cloud/compute');
const compute = new Compute({projectId: 'tigertmp',});
const zone = compute.zone('us-east1-b');
const instanceGroup = zone.instanceGroup('mandel-private-group');

const updateDelay = 10 * 1000;
const updatesKeepAlive = 2; // number of updates after the last request
let numUpdates = 0;
let updateIPs = true;
let MANDEL_IPS = ['34.70.125.180']; // one public ip address to help initialize the connection
let lastUsedIndex = 0;
const MANDEL_PORT = 80;
let updateRunner = undefined;
// GET IP END

// const MANDEL_IPS = ['34.70.125.180', '104.196.109.6', '34.73.0.188'];

const port = 80; // Node server port

const app = express();
app.use(morgan('dev'));

// Holds Mandel proto types
let mandel = {};

// custom body parser for protobuf type
app.use(function (req, res, next) {
  if (!req.is('application/octet-stream')) return next();
  var data = [];
  req.on('data', chunk => {
    data.push(chunk);
  });
  req.on('end', () => {
    if (data.length <= 0) return next();
    data = Buffer.concat(data);
    // console.log('Received buffer', data);
    req.raw = data;
    next();
  });
});

// Load proto defs and then set up routes
protobuf.load("mandel.proto", (err, root) => {
  if (err) {
    throw err; // Failed to load proto def.
  }

  // Set up Proto types
  mandel.MandelRequest = root.lookupType("mandel.MandelRequest");
  mandel.MandelResponse = root.lookupType("mandel.MandelResponse");
  mandel.IntRect = root.lookupType("mandel.IntRect");
  mandel.DoubleRect = root.lookupType("mandel.DoubleRect");

  // Expess Routing
  app.post('/', (req, res, next) => {
    handlePostRoot(req, res).catch(err => next(err));
  });

  // Reroute GET to the github URL
  app.get('*', (req, res, next) => {
    res.redirect("https://github.com/tgmeow/mandel-canvas");
    next();
  });

  // Error handler
  app.use((err, req, res, next) => {
    if (res.headersSent) {
      return next(err);
    }
    console.error(err.stack);
    return res.status(500).send(err);
  });

  const server = app.listen(port, () => console.log(`Example app listening on port ${port}!`));

  pokeUpdater();

  // Keeps client connections open for longer
  server.keepAliveTimeout = 60 * 1000;
  server.headersTimeout = 65 * 1000;
});

/**
 * Handles all the req res, and will THROW on error.
 * @param req
 * @param res
 * @returns {Promise<void>}
 */
async function handlePostRoot(req, res) {
  pokeUpdater(); // poke the mandel ip updater so we have fresh IP addresses.

  // Process the incoming request and try to extract the protobuf message.
  let incomingMandReq = readProtoReq(req);

  // break up request and send to multiple unikernels.
  let min = incomingMandReq.ib.ymin;
  let max = incomingMandReq.ib.ymax;
  let range = max - min;
  let responses = [];

  let numSplits = Math.min(max - min, MANDEL_IPS.length);

  // split to number of requests equal to number of servers
  for (let i = 0; i < numSplits; i++) {
    let splitMin = Math.round(min + i * range / numSplits);
    let splitMax = Math.round(Math.min(min + (i + 1) * range / numSplits, max));

    let cur_request = {
      cb: incomingMandReq.cb,
      ib: {xmin: incomingMandReq.ib.xmin, xmax: incomingMandReq.ib.xmax, ymin: splitMin, ymax: splitMax},
      maxIter: incomingMandReq.maxIter,
      viewWidth: incomingMandReq.viewWidth,
      viewHeight: incomingMandReq.viewHeight
    };
    verifyMandReq(cur_request);
    // Turn broken up request back into buffers
    let unikBuffer = mandel.MandelRequest.encode(cur_request).finish();
    let cur_index = (i + lastUsedIndex) % MANDEL_IPS.length;
    let cur_res = runMandelComputation(MANDEL_IPS[cur_index], MANDEL_PORT, unikBuffer);
    responses.push(cur_res);
  }
  lastUsedIndex = (lastUsedIndex + numSplits) % MANDEL_IPS.length; // cycle across requests.
  // Send request to unikernel(s) and await all
  let finishedMandRes = await Promise.all(responses);

  // Process responses and turn MandelResponses into one big response.
  // Since the request should be a rectangle, we will put the pieces back into one long data array.
  let data = [];
  finishedMandRes.forEach(d => {
    data = data.concat(d.data);
  });

  let unikMandRes = {
    data: data,
    ib: incomingMandReq.ib
  };

  // Send back the mandel response.
  sendProtoRes(res, unikMandRes);
}

/**
 * Read the request and return the MandelRequest
 * @param req
 * @returns {Message<{}>}
 */
function readProtoReq(req) {
  if (!req.raw) {
    throw new Error("Missing protobuf data.");
  }
  let incomingBuffer = req.raw;
  // console.log(incomingBuffer);

  return mandel.MandelRequest.decode(incomingBuffer);
}

/**
 * Send the proto response back.
 * @param res
 * @param mandRes MandelResponse
 */
function sendProtoRes(res, mandRes) {
  verifyMandelRes(mandRes);
  let outgoingMandRes = mandel.MandelResponse.encode(mandRes).finish();
  // Send back response
  res.status(200).send(outgoingMandRes);
}

/**
 * Verify that can be encoded without issues.
 * @param mandReq
 */
function verifyMandReq(mandReq) {
  let errMsg = mandel.MandelRequest.verify(mandReq);
  if (errMsg) {
    throw new Error(errMsg);
  }
}

/**
 * Verify that can be encoded without issues.
 * @param mandRes
 */
function verifyMandelRes(mandRes) {
  let errMsg = mandel.MandelResponse.verify(mandRes);
  if (errMsg) {
    throw new Error(errMsg);
  }
}


/**
 * Connects to a single ip:port to send a MandelRequest buffer.
 * @param ip
 * @param port
 * @param buffer
 * @returns {Promise<Message<{}>>}
 */
async function runMandelComputation(ip, port, buffer) {
  let timeout = 750;
  let result = await MandelClient.sendAsyncRequest(ip, port, buffer, timeout);
  let errMsg = mandel.MandelResponse.verify(result);
  if (errMsg) {
    throw Error("MandelResponse verify failed.");
  }
  return mandel.MandelResponse.decode(result);
}

// getIPs(instanceGroup);

async function getUpdatedIPs() {
  if (numUpdates <= 0) {
    updateIPs = false;
  }
  if (!updateIPs) {
    clearInterval(updateRunner);
    updateRunner = undefined;
    return;
  }
  numUpdates--;
  let groupVMs = await instanceGroup.getVMs({running: true});
  let vmArr = groupVMs[0];
  let vmMetasPromises = vmArr.map(vm => vm.getMetadata());
  let vmMetas = await Promise.all(vmMetasPromises);
  // console.log(vmMetas.length);
  MANDEL_IPS = vmMetas.map(vm => vm[0].networkInterfaces[0].networkIP);
  shuffle(MANDEL_IPS); // Put in random order to help balance some of the load.
  console.log("Number of Unikernel IPs: ", MANDEL_IPS.length);
}

function pokeUpdater() {
  updateIPs = true;
  numUpdates = updatesKeepAlive; // reset numUpdates
  // Start runner if it is not already running.
  if (updateRunner === undefined) {
    updateRunner = setInterval(getUpdatedIPs, updateDelay);
  }
}

/**
 * Shuffles array in place.
 * @param {Array} a items An array containing the items.
 */
function shuffle(a) {
  var j, x, i;
  for (i = a.length - 1; i > 0; i--) {
    j = Math.floor(Math.random() * (i + 1));
    x = a[i];
    a[i] = a[j];
    a[j] = x;
  }
  return a;
}
