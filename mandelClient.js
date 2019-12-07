'use strict';
/**
 * Client for connecting to the Unikernel backend.
 * @type {module:net}
 */

const net = require('net');
const Networker = require('./networker.js');

let MandelClient = {};

/**
 * Sends a buffer to a unikernel and resolves the Promise with the response.
 * @param ip
 * @param port
 * @param buffer
 * @param timeout
 * @returns {Promise<Buffer>}
 */
MandelClient.sendAsyncRequest = function (ip, port, buffer, timeout = 2000) {
  return new Promise((res, rej) => {
    let timer;
    let socket = net.createConnection({host: ip, port: port})
      .setTimeout(timeout)
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
};

module.exports = MandelClient;