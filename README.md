# Mandel Canvas Mono-repo
This repo contains all the code for running the Mandelbrot Viewer and the cloud backend version.   

## Folder Description
- mandelCanvas - Interactive Go client. Can be found in the [Releases](https://github.com/tgmeow/mandel-canvas/releases). Can use local computation or unikernel computation through the node server.   
- mandel - Non-interactive command line program that computes a mandelbrot image locally and saves it to a file.  
- unikernel-mandel - Contains the IncludeOS unikernel that runs the mandelbrot computation.   
- mandel-server - nodejs server that forwards MandelRequest data to unikernel backends.   
- mandel-go-function-tester - Script to test the performance of the node server and unikernel backend.   


