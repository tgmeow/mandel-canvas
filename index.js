"use strict";
let protobuf = require("protobufjs");
const MandelClient = require('./mandelClient');

// const MANDEL_IP = '35.226.1.156'; // LOOP/ECHO mandel-loop
const MANDEL_IP = '34.70.125.180'; // instance-17 // normal working
const MANDEL_PORT = 80;

let MandelRequest;
let MandelResponse;
let IntRect;
let DoubleRect;

protobuf.load("mandel.proto", async (err, root) => {
  // main
  if (err)
    throw Error(err);

  // Set up Proto types
  MandelRequest = root.lookupType("mandel.MandelRequest");
  MandelResponse = root.lookupType("mandel.MandelResponse");
  IntRect = root.lookupType("mandel.IntRect");
  DoubleRect = root.lookupType("mandel.DoubleRect");

  // Note: Not necessary to create into Message type.
  let dims = 10;
  let ib = IntRect.create({xmin: 0, xmax: dims, ymin:0, ymax:dims});
  let cb = DoubleRect.create({xmin: -1.5, xmax: 1, ymin:-1, ymax:1});
  let paramsPayload = {ib, cb, maxIter:100, viewWidth: dims, viewHeight:dims};
  let errMsg = MandelRequest.verify(paramsPayload);
  if (errMsg)
    throw Error(errMsg);
  let params = MandelRequest.create(paramsPayload);
  let buffer = MandelRequest.encode(params).finish();
  console.log(MandelRequest.decode(buffer));

  // Send the request, get response, and parse message.
  let mandRes = await runMandelComputation(MANDEL_IP, MANDEL_PORT, buffer);
  console.log(mandRes.data);
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


