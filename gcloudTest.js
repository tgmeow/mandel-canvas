'use strict';

const Compute = require('@google-cloud/compute');
const compute = new Compute({projectId: 'tigertmp',});
const zone = compute.zone('us-east1-b');
const instanceGroup = zone.instanceGroup('instance-group-1');

getIPs(instanceGroup);

async function getIPs(instanceGroup) {
  const groupVMs = await instanceGroup.getVMs();
  console.log(groupVMs);
}
