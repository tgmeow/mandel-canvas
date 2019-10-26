package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/widget"
	"image"
)

type gameWidget struct {
	xCenter, yCenter float64
	zoom, origHeight int
	zoomed           bool

	nMainThreads, nDirtyThreads int // Number of threads used. Passed to the renderer.

	// TODO assuming this part is single threaded
	drag image.Point // Keeps track of dragging offset to move the img rather than redraw

	size     fyne.Size     // Widget size
	position fyne.Position // Widget position
	hidden   bool          // show/hide widget
}

/**** Canvas Object ****/
var _ fyne.CanvasObject = (*gameWidget)(nil)

func (g *gameWidget) Size() fyne.Size { return g.size }
func (g *gameWidget) Resize(size fyne.Size) {
	g.size = size
	widget.Renderer(g).Layout(size)
}
func (g *gameWidget) Position() fyne.Position { return g.position }
func (g *gameWidget) Move(pos fyne.Position) {
	g.position = pos
	widget.Renderer(g).Layout(g.size)
}
func (g *gameWidget) MinSize() fyne.Size { return widget.Renderer(g).MinSize() }
func (g *gameWidget) Visible() bool      { return !g.hidden }
func (g *gameWidget) Show()              { g.hidden = false }
func (g *gameWidget) Hide()              { g.hidden = true }

/**** Widget ****/
var _ fyne.Widget = (*gameWidget)(nil)

func (g *gameWidget) CreateRenderer() fyne.WidgetRenderer {
	renderer := &gameRenderer{gw: g, nMainThreads: g.nMainThreads, nDirtyThreads: g.nDirtyThreads}
	// Provides width/height! Raster renders using the provided draw func.
	render := canvas.NewRaster(renderer.draw)
	// TODO compare performance with NewRasterWithPixels. With Pixels runs new compute for each pixel.
	// https://godoc.org/fyne.io/fyne/canvas#NewRasterWithPixels
	renderer.canvas = render
	renderer.objects = []fyne.CanvasObject{render}
	return renderer
}

/****  Mouse Interactions ****/
//var _ fyne.Tappable = (*gameWidget)(nil)
//func (g *gameWidget) Tapped(ev *fyne.PointEvent) {}
//func (g *gameWidget) TappedSecondary(ev *fyne.PointEvent) {}

var _ fyne.Draggable = (*gameWidget)(nil)

func (g *gameWidget) Dragged(ev *fyne.DragEvent) {
	// Update drag history
	g.drag = g.drag.Add(image.Point{X: ev.DraggedX, Y: ev.DraggedY})

	// Move the computation viewport
	scale := -2.0 * zoomToScale(g.zoom) / float64(g.origHeight)
	g.xCenter += float64(ev.DraggedX) * scale
	g.yCenter += float64(ev.DraggedY) * scale
	// TODO ensure centers are multiples of something to improve caching.
	//fmt.Println(g.xCenter, g.yCenter)

	widget.Refresh(g)
}

func (g *gameWidget) DragEnd() {}

var _ fyne.Scrollable = (*gameWidget)(nil)

const (
	ZoomMax = 19
	ZoomMin = 0
)

func (g *gameWidget) Scrolled(ev *fyne.ScrollEvent) {
	prevZoom := g.zoom
	if ev.DeltaY < 0 {
		g.zoom = fyne.Max(g.zoom-1, ZoomMin)
	} else {
		g.zoom = fyne.Min(g.zoom+1, ZoomMax)
	}
	if prevZoom != g.zoom {
		g.zoomed = true
		widget.Refresh(g)
	}
}
