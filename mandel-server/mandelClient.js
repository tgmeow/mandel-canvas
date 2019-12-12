'use strict';
/**
 * Client for connecting to the Unikernel backend.
 * @type {module:net}
 */

const net = require('net');
const Networker = require('./networker.js');

let MandelClient = {};
const ipLock = {};

/**
 * Sends a buffer to a unikernel and resolves the Promise with the response.
 * Currently DOES NOT reuse the socket.
 * @param ip
 * @param port
 * @param buffer
 * @param timeout
 * @returns {Promise<Buffer>}
 */
// TODO bug in trying to connect BEFORE connection closes.
MandelClient.sendAsyncRequest = async function (ip, port, buffer, timeout = 2000) {
  if (ipLock[ip] !== undefined){
//    console.log("IP is busy: " + ip);
    await ipLock[ip];
    ipLock[ip] = undefined;
  }
  let resLockFunc;
  ipLock[ip] = new Promise((resLock, rejLock)=>{
	  resLockFunc = resLock;
  });
  return new Promise((res, rej) => {
    let timer;
    let socket = net.createConnection({host: ip, port: port})
      .setTimeout(500)
      .on('connect', () => {
//	      console.log("CONNECT: " + ip);
        let networker = new Networker(socket, data => {
		clearTimeout(timer);
	  socket.end(()=>{
		  res(data);
	  });
        });
        networker.init();
        // console.log('Sending Buffer.');
        networker.send(buffer);
      }).on('timeout', () => {
	      clearTimeout(timer);
        socket.destroy();
        rej(new Error("Timeout connecting to unikernel: " + ip));
      }).on('error', err => {
	      clearTimeout(timer);
	socket.destroy();
        console.log(err);
        rej(err);
      }).on('close', ()=>{
//	      console.log('CLOSED ' + ip);
	   setTimeout(() => {resLockFunc();}, 7); // 7 is an arbitrary value to wait before resolving.
      }).on('end', ()=>{
//	      console.log('END ' + ip);
      });

    timer = setTimeout(async ()=>{
	    socket.end();
//      socket.destroy();
//	    console.log(ipLock);
      ipLock[ip] = undefined;
	   setTimeout(() => {resLockFunc();}, 5);
      console.log('TIMEDOUT: ' + ip);
      rej(new Error("Timeout waiting for response."));
    }, timeout);
  });
};

module.exports = MandelClient;
