package main

import (
	"fyne.io/fyne/app"
)

func newGameWidget() *gameWidget {
	return &gameWidget{
		xCenter:  -0.5,
		zoom:    0,
		origHeight: 512,
		nMainThreads: 32,
		nDirtyThreads: 16,
	}
}

func main() {
	gameApp := app.New()

	//width, height := 512, 512
	// New gw widget
	gameWidget := newGameWidget()
	//gameWidget.Resize(fyne.NewSize(width, height))
	window := gameApp.NewWindow("Mandel App")
	window.SetPadded(false)
	window.SetContent(gameWidget)

	window.ShowAndRun()
}
