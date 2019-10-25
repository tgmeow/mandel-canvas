package main

import (
	"fmt"
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/widget"
	"image"
)

// Make sure our struct implements these interfaces.
var _ fyne.Draggable = (*game)(nil)
var _ fyne.CanvasObject = (*game)(nil)
var _ fyne.Tappable = (*game)(nil)
var _ fyne.Widget = (*game)(nil)

type game struct {
	image image.Image // used to be board

	size     fyne.Size
	position fyne.Position
	hidden   bool
}

func (g *game) Size() fyne.Size {
	return g.size
}

func (g *game) Resize(size fyne.Size) {
	g.size = size
	widget.Renderer(g).Layout(size)
}

func (g *game) Position() fyne.Position {
	return g.position
}

func (g *game) Move(pos fyne.Position) {
	g.position = pos
	widget.Renderer(g).Layout(g.size)
}

func (g *game) MinSize() fyne.Size {
	return widget.Renderer(g).MinSize()
}

func (g *game) Visible() bool {
	return !g.hidden
}

func (g *game) Show() {
	g.hidden = false
}

func (g *game) Hide() {
	g.hidden = true
}


func (g *game) CreateRenderer() fyne.WidgetRenderer {
	renderer := &gameRenderer{game: g}

	// Provides width/height! Raster renders using the provided draw func.
	render := canvas.NewRaster(renderer.draw)
	renderer.render = render
	renderer.objects = []fyne.CanvasObject{render}
	renderer.ApplyTheme()

	return renderer
}


//func (g *game) typedRune(r rune) {
//	if r == ' ' {
//		g.toggleRun()
//	}
//}

func (g *game) Tapped(ev *fyne.PointEvent) {
	//fmt.Println(ev.Position.X)
	//fmt.Println(ev.Position.Y)
	//widget.Refresh(g)
}

func (g *game) Dragged(ev *fyne.DragEvent) {
	fmt.Println(ev.Position.X)
	fmt.Println(ev.Position.Y)
	// Dragged is the offset
	fmt.Println(ev.DraggedX)
	fmt.Println(ev.DraggedY)
}

func (g *game) DragEnd() {

}

func (g *game) TappedSecondary(ev *fyne.PointEvent) {
}
