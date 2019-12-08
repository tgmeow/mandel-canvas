// Copied from https://gist.github.com/anonymous/e9e87ba3947900869022650d673724f7#file-networker-js
// Then modified slightly to work with my Unikernel implementation.
'use strict';

const debug = require('debug')('network');

function Networker(socket, handler) {
    this.socket = socket;
    this._packet = {};

    this.sent = false;
    this._process = false;
    this._state = 'HEADER';
    this._payloadLength = 0;
    this._bufferedBytes = 0;
    this.queue = [];

    this.handler = handler;
}

// TODO: May not be efficient with reusing connections. But at least it's working.
Networker.prototype.init = function () {
    this.socket.on('data', (data) => {
        if (!this.sent) {
            this.sent = true;
            // For some reason the header from the outgoing message gets caught here.
            // console.log(data);
            return;
        }
        this._bufferedBytes += data.length;
        this.queue.push(data);
        console.log('PUSH DATA');
        console.log(data);

        this._process = true;
        this._onData();
    });

    this.socket.on('served', this.handler);
};

Networker.prototype._hasEnough = function (size) {
    if (this._bufferedBytes >= size) {
        return true;
    }
    this._process = false;
    return false;
};

Networker.prototype._readBytes = function (size) {
    let result;
    this._bufferedBytes -= size;

    if (size === this.queue[0].length) {
        return this.queue.shift();
    }

    if (size < this.queue[0].length) {
        result = this.queue[0].slice(0, size);
        this.queue[0] = this.queue[0].slice(size);
        return result;
    }

    result = Buffer.allocUnsafe(size);
    let offset = 0;
    let length;

    while (size > 0) {
        length = this.queue[0].length;

        if (size >= length) {
            this.queue[0].copy(result, offset);
            offset += length;
            this.queue.shift();
        } else {
            this.queue[0].copy(result, offset, 0, size);
            this.queue[0] = this.queue[0].slice(size);
        }

        size -= length;
    }

    return result;
};

Networker.prototype._getHeader = function () {
    const PAYLOAD_LENGTH_BYTES = 4;
    if (this._hasEnough(PAYLOAD_LENGTH_BYTES)) {
        this._payloadLength = this._readBytes(PAYLOAD_LENGTH_BYTES).readUInt32BE(0, true);
        // console.log("PAYLOAD_LENGTH: " + this._payloadLength);
        this._state = 'PAYLOAD';
    }
};

Networker.prototype._getPayload = function () {
    // console.log("HEADER-getpayload" + this._payloadLength);
    if (this._hasEnough(this._payloadLength)) {
        let received = this._readBytes(this._payloadLength);
        // console.log(received);
        this.socket.emit('served', received);
        this._state = 'HEADER';
    }
    // else {
    //     console.log("Bad payload length?");
    //     console.log(this._bufferedBytes);
    // }
};

Networker.prototype._onData = function (data) {
    while (this._process) {
        switch (this._state) {
            case 'HEADER':
                this._getHeader();
                break;
            case 'PAYLOAD':
                this._getPayload();
                break;
        }
    }
};

Networker.prototype.send = function (buffer) {
    // let buffer = Buffer.from(message);
    this._header(buffer.length);
    this._packet.message = buffer;
    this._send();
};

Networker.prototype._header = function (messageLength) {
    this._packet.header = { length: messageLength };
};

Networker.prototype._send = function () {
    let contentLength = Buffer.allocUnsafe(2);
    contentLength.writeUInt16BE(this._packet.header.length);
    debug('Attempting to write...', this._packet);
    this.socket.write(contentLength);
    this.socket.write(this._packet.message);
    this._packet = {};
};

module.exports = Networker;