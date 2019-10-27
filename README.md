Mandel Canvas
==============
Go (golang) project using the Fyne framework to create an interactive canvas for viewing the Mandelbrot Set.
 The computation runs in multiple threads (go routines) to speed up the render. 

Building and Running
--------
See [Releases](https://github.com/tgmeow/mandel-canvas/releases) for the latest official builds.
_________________
You can also build from source easily.
1. Install Go
2. ```go get fyne.io/fyne/...```
3. ```git clone https://github.com/tgmeow/mandel-canvas```
4. ```cd mandel-canvas/mandelCanvas```
5. ```go build```


Controls
---------
 As of v1.1, only enabled mouse controls are implemented.
 - Scroll Zoom
 - Click and drag
 - Right click - Print image config to the console
 