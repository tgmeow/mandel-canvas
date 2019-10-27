package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/theme"
	"image"
	"image/color"
	"image/draw"
)

type gameRenderer struct {
	canvas  fyne.CanvasObject
	img     *image.NRGBA
	objects []fyne.CanvasObject // required by interface (?)
	gw      *gameWidget
}

/**** WidgetRenderer ****/
var _ fyne.WidgetRenderer = (*gameRenderer)(nil)

func (g *gameRenderer) Layout(size fyne.Size) { g.canvas.Resize(size) }

// Initial default size
func (g *gameRenderer) MinSize() fyne.Size { return fyne.NewSize(g.gw.origHeight, g.gw.origHeight) }

// On widget refresh, canvas the underlying items
func (g *gameRenderer) Refresh()                     { canvas.Refresh(g.canvas) }
func (g *gameRenderer) ApplyTheme()                  {}
func (g *gameRenderer) BackgroundColor() color.Color { return theme.BackgroundColor() }
func (g *gameRenderer) Objects() []fyne.CanvasObject { return g.objects }
func (g *gameRenderer) Destroy()                     {}

// Returns true if the image is nil or sizes mismatch
func (g *gameRenderer) needNewImage(w, h int) bool {
	return g.img == nil || g.img.Bounds().Size().X != w || g.img.Bounds().Size().Y != h
}

// Calculates the dirty rectangles on the screen as a result of a drag.
// Assumes drag distance is less than the screen size.
func (g *gameRenderer) calcDirtyRectangles() []*image.Rectangle {
	b := g.img.Bounds()
	ibA := make([]*image.Rectangle, 0, 3)
	// Calculate dirty rectangles
	innerInt := b.Max.Add(g.gw.drag).Mod(b)
	outerInt := innerInt.Sub(g.gw.drag)

	if g.gw.drag.X != 0 {
		dirtyX := image.Rect(innerInt.X, innerInt.Y, outerInt.X, b.Max.Y-outerInt.Y)
		ibA = append(ibA, &dirtyX)
	}
	if g.gw.drag.Y != 0 {
		dirtyY := image.Rect(innerInt.X, innerInt.Y, b.Max.X-outerInt.X, outerInt.Y)
		ibA = append(ibA, &dirtyY)
	}
	if g.gw.drag.X != 0 && g.gw.drag.Y != 0 {
		dirtyInt := image.Rect(innerInt.X, innerInt.Y, outerInt.X, outerInt.Y)
		ibA = append(ibA, &dirtyInt)
	}
	return ibA
}

// Function for drawing the pixels of the canvas.
func (g *gameRenderer) draw(w, h int) image.Image {
	// Update compute bounds each draw
	cb := getComputeBounds64(g.gw.xCenter, g.gw.yCenter, g.gw.zoom, w, h, g.gw.origHeight)

	// Full redraw on create, zoom, or resize
	if g.needNewImage(w, h) || g.gw.zoomed {
		g.gw.zoomed = false
		// Create a new image of the correct size
		ib := image.Rect(0, 0, w, h)
		g.img = image.NewNRGBA(ib)
		computeImage64(g.img, &cb, []*image.Rectangle{&ib}, g.gw.nThreads)
		// Reset drag vars. Drag will have been already calculated in the full redraw, making it not necessary.
		g.gw.drag = image.Point{}
		return g.img
	}
	b := g.img.Bounds()
	// Redraw existing img on top at the drag offset https://blog.golang.org/go-imagedraw-package
	draw.Draw(g.img, b, g.img, b.Min.Sub(g.gw.drag), draw.Src)

	// Redraw dirty parts
	dirtyRects := g.calcDirtyRectangles()
	computeImage64(g.img, &cb, dirtyRects, g.gw.nThreads)
	// Reset drag vars for next draw
	g.gw.drag = image.Point{}

	return g.img
}
