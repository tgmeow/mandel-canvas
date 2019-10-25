package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/widget"
)

type gameWidget struct {
	xCenter float64
	yCenter float64
	scale   float64
	maxIter int

	size     fyne.Size // Widget size
	position fyne.Position // Widget position
	hidden   bool // show/hide widget
}


/**** Canvas Object ****/
var _ fyne.CanvasObject = (*gameWidget)(nil)

func (g *gameWidget) Size() fyne.Size {return g.size}
func (g *gameWidget) Resize(size fyne.Size) {
	g.size = size
	widget.Renderer(g).Layout(size)
}
func (g *gameWidget) Position() fyne.Position {return g.position}
func (g *gameWidget) Move(pos fyne.Position) {
	g.position = pos
	widget.Renderer(g).Layout(g.size)
}
func (g *gameWidget) MinSize() fyne.Size {return widget.Renderer(g).MinSize()}
func (g *gameWidget) Visible() bool {return !g.hidden}
func (g *gameWidget) Show() {g.hidden = false}
func (g *gameWidget) Hide() {g.hidden = true}


/**** Widget ****/
var _ fyne.Widget = (*gameWidget)(nil)

func (g *gameWidget) CreateRenderer() fyne.WidgetRenderer {
	renderer := &gameRenderer{gw: g}
	// Provides width/height! Raster renders using the provided draw func.
	render := canvas.NewRaster(renderer.draw)
	// TODO compare performance with NewRasterWithPixels
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
	//fmt.Println(ev.Position.X)
	//fmt.Println(ev.Position.Y)
	//// Dragged is the offset
	//fmt.Println(ev.DraggedX)
	//fmt.Println(ev.DraggedY)
	// TODO move the viewport
	width := float64(g.size.Width)
	height := float64(g.size.Height)
	ratio := width / height
	xRange := -2.0 * g.scale * ratio
	yRange := -2.0 * g.scale
	diffX := float64(ev.DraggedX) * xRange / width
	diffY := float64(ev.DraggedY) * yRange / height
	//fmt.Println(diffX)
	//fmt.Println(diffY)
	g.xCenter += diffX
	g.yCenter += diffY
	widget.Refresh(g)
	// TODO Max redraw rate
}

func (g *gameWidget) DragEnd() {}

var _ fyne.Scrollable = (*gameWidget)(nil)

func (g *gameWidget) Scrolled(*fyne.ScrollEvent) {
	// TODO zooming
	//panic("implement me")
	// TODO Max redraw rate
}
