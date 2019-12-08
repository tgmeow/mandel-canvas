'use strict';
const MandelClient = require('./mandelClient');
const protobuf = require("protobufjs");
const morgan = require('morgan');
const express = require('express');

// Unikernel address
// const MANDEL_IP = '34.70.125.180'; // instance-17 // normal working/
const MANDEL_IPS = ['34.70.125.180', '104.196.109.6', '34.73.0.188'];
const numOfUnikernels = MANDEL_IPS.length;
const MANDEL_PORT = 80;

const port = 8080; // Node server port

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

  // Error handler
  app.use((err, req, res, next) => {
    if (res.headersSent) {
      return next(err);
    }
    console.error(err.stack);
    return res.status(500).send(err);
  });

  const server = app.listen(port, () => console.log(`Example app listening on port ${port}!`));

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
  // Process the incoming request and try to extract the protobuf message.
  let incomingMandReq = readProtoReq(req);

  // break up request and send to multiple unikernels.
  let min = incomingMandReq.ib.ymin;
  let max = incomingMandReq.ib.ymax;
  let responses = [];

  for (let i = min; i < max; i++) {
    let cur_request = {
      cb: incomingMandReq.cb,
      ib: {xmin: incomingMandReq.ib.xmin, xmax: incomingMandReq.ib.xmax, ymin: i, ymax: i + 1},
      maxIter: incomingMandReq.maxIter,
      viewWidth: incomingMandReq.viewWidth,
      viewHeight: incomingMandReq.viewHeight
    };
    verifyMandReq(cur_request);
    // Turn broken up request back into buffers
    let unikBuffer = mandel.MandelRequest.encode(cur_request).finish();
    let cur_index = i % numOfUnikernels;
    let cur_res = runMandelComputation(MANDEL_IPS[cur_index], MANDEL_PORT, unikBuffer);
    responses.push(cur_res);
  }
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
  let timeout = 4000;
  let result = await MandelClient.sendAsyncRequest(ip, port, buffer, timeout);
  let errMsg = mandel.MandelResponse.verify(result);
  if (errMsg) {
    throw Error("MandelResponse verify failed.");
  }
  return mandel.MandelResponse.decode(result);
}