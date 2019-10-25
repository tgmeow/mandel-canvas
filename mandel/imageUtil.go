package main

import (
	"fmt"
	"image"
	"image/color"
	"image/png"
	"log"
	"os"
)

// Fills an image with a single color.
func imageFill(img *image.NRGBA, c color.Color) {
	bounds := img.Bounds()
	for y := bounds.Min.Y; y < bounds.Max.Y; y++ {
		for x := bounds.Min.X; x < bounds.Max.X; x++ {
			img.Set(x, y, c)
		}
	}
}

// Writes an image img to the disk, and exits the program on error.
func writeImageToDisk(img image.Image, fileName string) {
	outputFile, err := os.Create(fileName)
	if err != nil {
		log.Fatal(fmt.Sprintf("Failed to create output file %v", err))
	}
	if err := png.Encode(outputFile, img); err != nil {
		_ = outputFile.Close()
		log.Fatal(err)
	}
	if err := outputFile.Close(); err != nil {
		log.Fatal(err)
	}
	log.Printf("Successfully wrote image %s\n", fileName)
}
