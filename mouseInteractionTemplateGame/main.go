package main

import (
	"fyne.io/fyne/app"
)

func newGame() *game {
	g := &game{}

	return g
}

func main() {
	gameApp := app.New()

	game := newGame()

	window := gameApp.NewWindow("Game App")
	window.SetContent(game)

	// Set On Keypress
	//window.Canvas().SetOnTypedRune(game.typedRune)

	// call to "animate" to begin drawing

	window.ShowAndRun()
}
