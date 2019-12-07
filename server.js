'use strict';
const MandelClient = require('./mandelClient');
let protobuf = require("protobufjs");
const express = require('express');
const app = express();
const port = 8080;

const MANDEL_IP = '34.70.125.180'; // instance-17 // normal working
const MANDEL_PORT = 80;

let MandelRequest;
let MandelResponse;
let IntRect;
let DoubleRect;

app.use(function(req, res, next) {
  if(!req.is('application/octet-stream')) return next();
  var data = [];
  req.on('data', chunk => {
    data.push(chunk);
  });
  req.on('end', () => {
    if(data.length <= 0) return next();
    data = Buffer.concat(data);
    // console.log('Received buffer', data);
    req.raw = data;
    next();
  });
});

protobuf.load("mandel.proto", (err, root) => {
  if (err)
    throw Error(err);

  // Set up Proto types
  MandelRequest = root.lookupType("mandel.MandelRequest");
  MandelResponse = root.lookupType("mandel.MandelResponse");
  IntRect = root.lookupType("mandel.IntRect");
  DoubleRect = root.lookupType("mandel.DoubleRect");

  app.post('/', async (req, res, next) => {

    try {
      if (!req.raw) {
        res.status(400).send("Missing protobuf data.");
        return;
      }
      let incomingBuffer = req.raw;
      // console.log(incomingBuffer);
      let errMsg = MandelRequest.verify(incomingBuffer);
      if (errMsg) {
        res.status(400).send(errMsg);
        return;
      }

      let incomingMandReq = MandelRequest.decode(incomingBuffer);
      // console.log(incomingMandReq);
      // TODO do something with the request (break it up) and send to multiple unikernels.

      // Turn processed request back into buffer
      errMsg = MandelRequest.verify(incomingMandReq);
      if (errMsg) {
        res.status(500).send(errMsg);
        return;
      }
      let unikBuffer = MandelRequest.encode(incomingMandReq).finish();
      // Send request to unikernel(s)

      let unikMandRes = await runMandelComputation(MANDEL_IP, MANDEL_PORT, unikBuffer);

      // TODO Process responses and turn MandelResponses into one big response

      // Turn response back into buffer
      errMsg = MandelResponse.verify(unikMandRes);
      if (errMsg) {
        res.status(500).send(errMsg);
        return;
      }
      let outgoingMandRes = MandelResponse.encode(unikMandRes).finish();
      // Send back response
      res.status(200).send(outgoingMandRes);
    } catch (e) {
      next(e);
    }
  });

  app.listen(port, () => console.log(`Example app listening on port ${port}!`));
});

async function runMandelComputation(ip, port, buffer) {
  let timeout = 4000;
  let result = await MandelClient.sendAsyncRequest(ip, port, buffer, timeout);
  let errMsg = MandelResponse.verify(result);
  if (errMsg) {
    throw Error("MandelResponse verify failed.");
  }
  return MandelResponse.decode(result);
}