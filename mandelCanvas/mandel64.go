package main

import (
	"fyne.io/fyne"
	"image"
	"image/color"
	"math"
	"sync"
)

// Bounds for the xy coordinates that the image shows.
type ComputeBounds64 struct {
	xMin, xMax, yMin, yMax float64
	zoom, maxIter          int
}

const ZoomPower = 2.5

// Calculate the scale inverse, given a zoom. Preferable, since does not calc the 1.0 / val.
func zoomToScaleInv(zoom int) float64 {
	return math.Pow(ZoomPower, float64(zoom))
}

// Converts 1/scale into maxIter
func scaleInvToMaxIter(scale float64) int {
	return int(100 * (1 + math.Pow(math.Log10(scale), 1.25)))
}

// Creates a ComputeBounds struct from the necessary parameters using float64.
func getComputeBounds64(xCenter, yCenter float64, zoom, width, height, origHeight int) ComputeBounds64 {
	scale := zoomToScaleInv(zoom)
	soH := scale * float64(origHeight)
	wAdj := float64(width) / soH
	hAdj := float64(height) / soH
	// Content stays the same size regardless of window size.
	return ComputeBounds64{
		xMin:    xCenter - wAdj,
		xMax:    xCenter + wAdj,
		yMin:    yCenter - hAdj,
		yMax:    yCenter + hAdj,
		maxIter: scaleInvToMaxIter(scale),
		zoom:    zoom,
	}
}

// Map a number of iterations to a color
func iterationToColor64(iter, maxIter int) color.Color {
	if iter == maxIter {
		return color.Gray{Y: 0}
	}
	val := uint8(math.MaxUint8 * float64(iter) / float64(maxIter))
	return color.Gray{Y: val}
}

// Computes the color at a point xy in the Mandelbrot space, up to max iterations.
func colorAtPoint64(x, y float64, maxIter int) color.Color {
	x0, y0, iter := x, y, 0
	for ; (x*x+y*y <= 4) && (iter < maxIter); iter++ {
		x, y = x*x-y*y+x0, 2*x*y+y0
	}
	return iterationToColor64(iter, maxIter)
}

// Worker thread for computeImage. Computes and writes to img for the image bounds ib.
func computeImageWorker64(wg *sync.WaitGroup, img *image.NRGBA, cb *ComputeBounds64, ib *image.Rectangle) {
	defer wg.Done()
	width := float64(img.Bounds().Max.X)
	height := float64(img.Bounds().Max.Y)
	xRange := cb.xMax - cb.xMin
	yRange := cb.yMax - cb.yMin
	for y := ib.Min.Y; y < ib.Max.Y; y++ {
		for x := ib.Min.X; x < ib.Max.X; x++ {
			ptX := cb.xMin + float64(x)*xRange/width
			ptY := cb.yMin + float64(y)*yRange/height
			c := colorAtPoint64(ptX, ptY, cb.maxIter)
			img.Set(x, y, c)
		}
	}
}

// Creates threads to compute the image. ib determines what bounds to draw at.
func computeImage64(img *image.NRGBA, cb *ComputeBounds64, ibA []*image.Rectangle, nThreads int) {
	//defer deferredTicToc.TicToc("computeImage")()
	var wg sync.WaitGroup
	for ibI := 0; ibI < len(ibA); ibI++ {
		ib := ibA[ibI]
		height := ib.Max.Y - ib.Min.Y
		nThreads = fyne.Min(height, nThreads) // Limit the number of threads to at most 1 per row
		sliceHeight := float64(height) / float64(nThreads)
		for i := 0; i < nThreads; i++ {
			// Slice image into rows.
			// TODO improve performance by splitting in the longer dimension
			ibTemp := *ib // Copy the existing values and reassign a slice.
			ibTemp.Min.Y = ib.Min.Y + int(float64(i)*sliceHeight)
			ibTemp.Max.Y = ib.Min.Y + int(float64(i+1)*sliceHeight)
			if i+1 == nThreads {
				ibTemp.Max.Y = ib.Max.Y // Run until the end.
			}
			wg.Add(1)
			go computeImageWorker64(&wg, img, cb, &ibTemp)
		}
	}
	wg.Wait()
}
