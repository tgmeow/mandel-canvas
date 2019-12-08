'use strict';

const Compute = require('@google-cloud/compute');
const compute = new Compute();
const zone = compute.zone('us-central1-a');
const instanceGroup = zone.instanceGroup('web-servers');
