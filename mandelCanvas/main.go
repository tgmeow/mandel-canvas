package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/app"
)

func newGameWidget(cb *ComputeBounds) *gameWidget {
	return &gameWidget{
		xCenter:  -0.5,
		scale:    1,
		maxIter:  100,
	}
}

func main() {
	gameApp := app.New()

	width, height := 512, 512
	cb := getComputeBounds(0, 0, 1, 100, width, height)
	// New gw widget
	gameWidget := newGameWidget(&cb)
	gameWidget.Resize(fyne.NewSize(width, height))
	window := gameApp.NewWindow("Mandel App")
	window.SetPadded(false)
	window.SetContent(gameWidget)

	window.ShowAndRun()
}
