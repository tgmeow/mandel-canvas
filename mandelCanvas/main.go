package main

import (
	"fyne.io/fyne/app"
)

func newGameWidget() *gameWidget {
	return &gameWidget{
		xCenter:    -0.5,
		zoom:       0,
		origHeight: 100,
		nThreads:   128,
	}
}

func main() {
	gameApp := app.New()

	// New gw widget
	gameWidget := newGameWidget()
	window := gameApp.NewWindow("Mandel App")
	window.SetPadded(false)
	window.SetContent(gameWidget)

	window.ShowAndRun()
}
