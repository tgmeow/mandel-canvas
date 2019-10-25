package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/theme"
	"image"
	"image/color"
)

type gameRenderer struct {
	canvas   fyne.CanvasObject
	imgCache *image.NRGBA
	objects  []fyne.CanvasObject // required by interface (?)
	gw       *gameWidget
}


/**** WidgetRenderer ****/
var _ fyne.WidgetRenderer = (*gameRenderer)(nil)

func (g *gameRenderer) Layout(size fyne.Size) {g.canvas.Resize(size)}
// Initial default size
func (g *gameRenderer) MinSize() fyne.Size {return fyne.NewSize(512, 512)}
// On widget refresh, canvas the underlying items
func (g *gameRenderer) Refresh() {canvas.Refresh(g.canvas)}
func (g *gameRenderer) ApplyTheme() {}
func (g *gameRenderer) BackgroundColor() color.Color {return theme.BackgroundColor()}
func (g *gameRenderer) Objects() []fyne.CanvasObject {return g.objects}
func (g *gameRenderer) Destroy() {}

// Function for drawing the pixels fo the canvas.Raster
func (g *gameRenderer) draw(w, h int) image.Image {
	img := g.imgCache
	// imgCache provides a template to build off of.
	if img == nil || img.Bounds().Size().X != w || img.Bounds().Size().Y != h {
		img = image.NewNRGBA(image.Rect(0, 0, w, h))
		g.imgCache = img
	}
	ib := ImageBounds{xMax: w, yMax: h}
	cb := getComputeBounds(g.gw.xCenter, g.gw.yCenter, g.gw.scale, g.gw.maxIter, w, h)
	// TODO draw mandel raster pixels, pull from cache when possible
	computeImage(img, &cb, &ib, 5)
	return img
}
