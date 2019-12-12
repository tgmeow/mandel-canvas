'use strict';

const Compute = require('@google-cloud/compute');
const compute = new Compute({projectId: 'tigertmp',});
const zone = compute.zone('us-east1-b');
const instanceGroup = zone.instanceGroup('instance-group-1');

const updateDelay = 10*1000;
const updatesKeepAlive = 2; // number of updates after the last request
let numUpdates = 0;
let updateIPs = true;

let mandelIPs = [];
let updateRunner = undefined;

// getIPs(instanceGroup);

async function getUpdatedIPs() {
  if(numUpdates <= 0) {
    updateIPs = false;
  }
  if (!updateIPs) {
    clearInterval(updateRunner);
    updateRunner = undefined;
    return;
  }
  numUpdates--;
  let groupVMs = await instanceGroup.getVMs({running:true});
  let vmArr = groupVMs[0];
  let vmMetasPromises = vmArr.map(vm => vm.getMetadata());
  let vmMetas = await Promise.all(vmMetasPromises);
  // console.log(vmMetas.length);
  mandelIPs = vmMetas.map(vm => vm[0].networkInterfaces[0].networkIP);
  console.log(mandelIPs);
}

function pokeUpdater(){
  numUpdates = updatesKeepAlive; // reset numUpdates
  // Start runner if it is not already running.
  if (updateRunner === undefined) {
    updateRunner = setInterval(getUpdatedIPs, updateDelay);
  }
}
