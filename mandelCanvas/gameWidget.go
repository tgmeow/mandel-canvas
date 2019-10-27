package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/widget"
	"image"
	"log"
	"math"
)

type gameWidget struct {
	xCenter, yCenter float64
	zoom, origHeight int
	zoomed           bool

	nThreads int // Number of threads used.

	drag               image.Point // Keeps track of ongoing drag to move the img. Reset on Draw.
	wasStationaryClick bool

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
	renderer := &gameRenderer{gw: g}
	render := canvas.NewRaster(renderer.draw)
	renderer.canvas = render
	renderer.objects = []fyne.CanvasObject{render}
	return renderer
}

// Rounds n to a multiple of x.
func roundNearest(n, x float64) float64 {
	return math.Round(n/x) * x
}

// Rounds the image centers to a multiple of scale.
func (g *gameWidget) roundCenters() {
	scale := -2.0 / (float64(g.origHeight) * zoomToScaleInv(g.zoom))
	g.xCenter = roundNearest(g.xCenter, scale)
	g.yCenter = roundNearest(g.yCenter, scale)
}

/****  Mouse Interactions ****/
var _ fyne.Tappable = (*gameWidget)(nil)

func (g *gameWidget) printImageConfig() {
	scaleInv := zoomToScaleInv(g.zoom)
	maxIter := scaleInvToMaxIter(scaleInv)
	log.Printf("Config: W=%d H=%d x=%.12f y=%.12f scale=%e maxIter=%d\n",
		g.size.Width, g.size.Height, g.xCenter, g.yCenter, 1.0/scaleInv, maxIter)
}

func (g *gameWidget) Tapped(ev *fyne.PointEvent) {
	g.wasStationaryClick = true
}
func (g *gameWidget) TappedSecondary(ev *fyne.PointEvent) {
	if g.wasStationaryClick {
		g.printImageConfig()
	}
	g.wasStationaryClick = true
}

var _ fyne.Draggable = (*gameWidget)(nil)

func (g *gameWidget) Dragged(ev *fyne.DragEvent) {
	// Update drag history
	g.wasStationaryClick = false
	g.drag = g.drag.Add(image.Point{X: ev.DraggedX, Y: ev.DraggedY})

	// Move the computation viewport
	scale := -2.0 / (float64(g.origHeight) * zoomToScaleInv(g.zoom))
	g.xCenter += float64(ev.DraggedX) * scale
	g.yCenter += float64(ev.DraggedY) * scale
	// Ensure centers are multiples of scale to improve caching.
	g.roundCenters()

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
		g.roundCenters()
		g.zoomed = true
		widget.Refresh(g)
	}
}
