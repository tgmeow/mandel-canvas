package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/theme"
	"image"
	"image/color"
)

// Makes sure the renderer implements these interfaces.
var _ fyne.Themeable = (*gameRenderer)(nil)
var _ fyne.WidgetRenderer = (*gameRenderer)(nil)

type gameRenderer struct {
	render   *canvas.Raster
	imgCache *image.RGBA
	objects  []fyne.CanvasObject // required by interface (?)
	game     *game
}

func (g *gameRenderer) MinSize() fyne.Size {
	return fyne.NewSize(500, 500) // Initial size
}

func (g *gameRenderer) Layout(size fyne.Size) {
	g.render.Resize(size)
}

func (g *gameRenderer) ApplyTheme() {
	// Set vars to etc etc such as to theme.BackgroundColor()
}

func (g *gameRenderer) BackgroundColor() color.Color {
	return theme.BackgroundColor()
}

// On widget refresh, render the underlying items
func (g *gameRenderer) Refresh() {
	canvas.Refresh(g.render)
}

func (g *gameRenderer) Objects() []fyne.CanvasObject {
	return g.objects // return empty, we have no objects
}

func (g *gameRenderer) Destroy() {
}

// Function for drawing the pixels fo the canvas.Raster
func (g *gameRenderer) draw(w, h int) image.Image {
	img := g.imgCache
	// imgCache provides a template to build off of.
	if img == nil || img.Bounds().Size().X != w || img.Bounds().Size().Y != h {
		img = image.NewRGBA(image.Rect(0, 0, w, h))
		g.imgCache = img
	}

	return img
}
