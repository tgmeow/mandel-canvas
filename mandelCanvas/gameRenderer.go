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
	nMainThreads, nDirtyThreads int
	canvas  fyne.CanvasObject
	img     *image.NRGBA
	objects []fyne.CanvasObject // required by interface (?)
	gw      *gameWidget
}


/**** WidgetRenderer ****/
var _ fyne.WidgetRenderer = (*gameRenderer)(nil)

func (g *gameRenderer) Layout(size fyne.Size) {g.canvas.Resize(size)}
// Initial default size
func (g *gameRenderer) MinSize() fyne.Size {return fyne.NewSize(g.gw.origHeight, g.gw.origHeight)}
// On widget refresh, canvas the underlying items
func (g *gameRenderer) Refresh() {canvas.Refresh(g.canvas)}
func (g *gameRenderer) ApplyTheme() {}
func (g *gameRenderer) BackgroundColor() color.Color {return theme.BackgroundColor()}
func (g *gameRenderer) Objects() []fyne.CanvasObject {return g.objects}
func (g *gameRenderer) Destroy() {}

// Returns true if the image is nil or size is wrong
func (g *gameRenderer) needNewImage(w, h int) bool {
	return g.img == nil || g.img.Bounds().Size().X != w || g.img.Bounds().Size().Y != h
}

// Function for drawing the pixels of the canvas
func (g *gameRenderer) draw(w, h int) image.Image {
	// Update compute bounds each draw
	cb := getComputeBounds64(g.gw.xCenter, g.gw.yCenter, g.gw.zoom, w, h, g.gw.origHeight)

	// Full redraw on create, zoom, or resize
	if g.needNewImage(w, h) || g.gw.zoomed {
		g.gw.zoomed = false
		// Create a new image of the correct size
		g.img = image.NewNRGBA(image.Rect(0, 0, w, h))
		ib := image.Rect(0, 0, w, h)
		computeImage64(g.img, &cb, []*image.Rectangle{&ib}, g.nMainThreads)
		return g.img
	}
	b := g.img.Bounds()
	// Draw on top at the drag offset
	draw.Draw(g.img, b, g.img, b.Min.Sub(g.gw.drag), draw.Src)

	// Calculate dirty rectangles https://blog.golang.org/go-imagedraw-package
	innerInt := b.Max.Add(g.gw.drag).Mod(b)
	outerInt := innerInt.Sub(g.gw.drag)
	dirtyX:= image.Rectangle{
		Min: innerInt,
		Max: image.Point{X: outerInt.X, Y: b.Max.Y - outerInt.Y,},
	}.Canon()
	dirtyY := image.Rectangle{
		Min: innerInt,
		Max: image.Point{X: b.Max.X - outerInt.X, Y: outerInt.Y,},
	}.Canon()
	dirtyInt := image.Rectangle{Min: innerInt, Max: outerInt}.Canon()

	// Redraw dirty portions
	ibA := make([]*image.Rectangle, 0, 3)
	if g.gw.drag.X != 0 {
		ibA = append(ibA, &dirtyX)
	}
	if g.gw.drag.Y != 0 {
		ibA = append(ibA, &dirtyY)
	}
	if g.gw.drag.X != 0 && g.gw.drag.Y != 0 {
		ibA = append(ibA, &dirtyInt)
	}
	computeImage64(g.img, &cb, ibA, g.nDirtyThreads)
	// Reset drag vars for next draw
	g.gw.drag.X, g.gw.drag.Y = 0, 0

	return g.img
}
