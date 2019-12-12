Mandel Canvas
==============
Go (golang) project using the Fyne framework to create an interactive canvas for viewing the Mandelbrot Set.
 The computation runs in multiple threads (go routines) or on unikernels remotely. 

Building and Running
--------
See [Releases](https://github.com/tgmeow/mandel-canvas/releases) for the latest official builds.
_________________
You can also build from source easily.
First install Go from their website.
```
sudo apt install xorg-dev
go get fyne.io/fyne/...
go get github.com/tgmeow/deferred-tic-toc
go get github.com/golang/protobuf/proto
go get github.com/pkg/errors
git clone https://github.com/tgmeow/mandel-canvas
cd mandel-canvas/mandelCanvas
go build .  # Will need other flags set if cross compiling. Fyne.io may also be missing X11 and glfw libraries.
```

To run with the unikernel backend, you will need to set up both mandel-server and unikernel-mandel. The existing mandelCanvas build that uses the cloud backend has an ip address hardcoded. That node server may or may not be running.

Controls
---------
 As of v1.1, only enabled mouse controls are implemented.
 - Scroll Zoom
 - Click and drag
 - Right click - Print image config to the console
