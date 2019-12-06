"use strict";
let protobuf = require("protobufjs");
// const axios = require('axios');
const net = require('net');
const Networker = require('./networker.js');

// const MANDEL_IP = '35.226.1.156'; // LOOP/ECHO mandel-loop
// const MANDEL_IP = '34.70.6.3'; // NO RESPONSE instance-6
// const MANDEL_IP = '35.239.108.181'; // E TIMED OUT mandel-image
// const MANDEL_IP = '34.66.243.221'; // instance-7
// const MANDEL_IP = '34.69.71.219'; // instance-8
// const MANDEL_IP = '104.198.218.102'; // instance-9
// const MANDEL_IP = '35.192.94.55'; // instance-10
// const MANDEL_IP = '34.70.125.180'; // instance-10
const MANDEL_IP = '35.192.94.55'; // mandel-image-nocomp
const MANDEL_PORT = 80;


protobuf.load("mandel.proto", async (err, root) => {
  // main

  if (err)
    throw Error(err);

  let MandelRequest = root.lookupType("mandel.MandelRequest");
  let MandelResponse = root.lookupType("mandel.MandelResponse");
  let IntRect = root.lookupType("mandel.IntRect");

  let paramsPayload = {ib: {xmin: 12, xmax: 17, ymin:11, ymax:12}, maxIter:1000000000};
  let errMsg = MandelRequest.verify(paramsPayload);
  if (errMsg)
    throw Error(errMsg);
  let params = MandelRequest.create(paramsPayload);
  let buffer = MandelRequest.encode(params).finish();
  // console.log(buffer);

  // Send the request, get response, and parse message.
  let timeout = 3000;
  try {
    let result = await sendAsyncReq(buffer, timeout);
    // console.log(result);
    errMsg = MandelResponse.verify(result);
    if (errMsg) {
      console.log("ERR :C");
      throw Error("Response verify failed.");
    }
    let message = MandelResponse.decode(result);
    console.log("GOT:");
    console.log(message);
  } catch (e) {
    console.log(e);
  }

});


/**
 * Sends a buffer to a unikernel and resolves the Promise with the response.
 * @param buffer
 * @param timeout
 * @returns {Promise<Buffer>}
 */
function sendAsyncReq(buffer, timeout = 2000) {
  return new Promise((res, rej) => {
    let timer;
    let socket = net.createConnection({host: MANDEL_IP, port: MANDEL_PORT})
      .on('connect', () => {
        let networker = new Networker(socket, data => {
          res(data);
          clearTimeout(timer); // Need to manually clear timer to clear events.
          socket.destroy();
        });
        networker.init();
        console.log('Sending Buffer.');
        networker.send(buffer);
      }).on('timeout', () => {
        // console.log("FAIL: Socket connection timeout.");
        socket.destroy();
        rej();
        clearTimeout(timer);
      }).on('error', err => {
        console.log(err);
        rej(err);
        clearTimeout(timer);
      });

    timer = setTimeout(()=>{
      rej(new Error("Timeout waiting for response."));
      socket.destroy();
    }, timeout);
  });
}