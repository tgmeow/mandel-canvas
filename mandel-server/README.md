# Node Server for Mandelbrot Cloud Computation
Nodejs Server, processes MandelRequests using Unikernel backends (see unikernel-mandel) and responds with a MandelResponse.  

The current set up has the unikernel backend running in an instance group on Google Cloud, and the node server will periodically ask Google Cloud for the instance group IPs.  

## Installation/Running
```bash
git clone
cd mandel-server
npm install
# Change the package.json file to your Google Cloud secret key.
# Modify the top of server.js to your own instance group name.
sudo npm start  # sudo is needed to listen on port 80.
```
