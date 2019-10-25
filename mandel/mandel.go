package main

import (
	"flag"
	"github.com/tgmeow/deferred-tic-toc"
	"image"
	"image/color"
	"math"
	"sync"
)

// Bounds for the xy coordinates that the image shows.
type ComputeBounds struct {
	xMin, xMax, yMin, yMax float64
	maxIter                int
}

// Bounds for the pixels of the image.
type ImageBounds struct {
	xMin, xMax, yMin, yMax int
}

// Creates a ComputeBounds struct from the necessary parameters.
func getComputeBounds(xCenter float64, yCenter float64, scale float64, maxIter int, width int, height int) ComputeBounds {
	ratio := float64(width) / float64(height)
	// ratio binds the content to the image height. Resizing width crops, height increases resolution.
	return ComputeBounds{
		xMin:    xCenter - scale*ratio,
		xMax:    xCenter + scale*ratio,
		yMin:    yCenter - scale,
		yMax:    yCenter + scale,
		maxIter: maxIter,
	}
}

// Map a number of iterations to a color
func iterationToColor(iter int, maxIter int) color.Color {
	val := uint8(math.MaxUint8 * float64(iter) / float64(maxIter))
	return color.Gray{Y: val}
}

// Computes the color at a point xy in the Mandelbrot space, up to max iterations.
func colorAtPoint(x float64, y float64, maxIter int) color.Color {
	x0, y0, iter := x, y, 0
	for ; (x*x+y*y <= 4) && (iter < maxIter); iter++ {
		x, y = x*x-y*y+x0, 2*x*y+y0
	}
	return iterationToColor(iter, maxIter)
}

// Worker thread for computeImage. Computes and writes to img for the bounds ib.
func computeImageWorker(wg *sync.WaitGroup, img *image.NRGBA, cb *ComputeBounds, ib *ImageBounds) {
	defer wg.Done()
	width := float64(img.Bounds().Max.X)
	height := float64(img.Bounds().Max.Y)
	xRange := cb.xMax - cb.xMin
	yRange := cb.yMax - cb.yMin
	for y := ib.yMin; y < ib.yMax; y++ {
		for x := ib.xMin; x < ib.xMax; x++ {
			ptX := cb.xMin + float64(x)*xRange/width
			ptY := cb.yMin + float64(y)*yRange/height
			c := colorAtPoint(ptX, ptY, cb.maxIter)
			img.Set(x, y, c)
		}
	}
}

// Creates threads to compute the image.
func computeImage(img *image.NRGBA, cb *ComputeBounds, ib *ImageBounds, nThreads int) {
	defer deferredTicToc.TicToc("computeImage")()
	var wg sync.WaitGroup
	height := img.Bounds().Max.Y
	sliceHeight := float64(height) / float64(nThreads)
	for i := 0; i < nThreads; i++ {
		// Slice image into rows.
		ibTemp := *ib // Copy the x values.
		ibTemp.yMin = int(float64(i) * sliceHeight)
		ibTemp.yMax = int(float64(i+1) * sliceHeight)
		if i+1 == nThreads {
			ibTemp.yMax = height // Run until the end.
		}
		wg.Add(1)
		go computeImageWorker(&wg, img, cb, &ibTemp)
	}
	wg.Wait()
}

func main() {
	// Set up flags.
	xCenterFlag := flag.Float64("x", -0.5, "X coordinate of image center point.")
	yCenterFlag := flag.Float64("y", 0.0, "Y coordinate of image center point.")
	scaleFlag := flag.Float64("s", 1.0, "Scale of the image in Mandlebrot coordinates.")
	imageWidthFlag := flag.Uint("W", 512, "Width of the image in pixels.")
	imageHeightFlag := flag.Uint("H", 512, "Height of the image in pixels.")
	maxIterFlag := flag.Uint("m", 100, "The maximum number of iterations per point.")
	fileNameFlag := flag.String("o", "mandel.png", "Set output file.")
	nThreadsFlag := flag.Uint("n", 1, "Number of threads to use.")
	flag.Parse()
	imageWidth := int(*imageWidthFlag)
	imageHeight := int(*imageHeightFlag)

	myImage := image.NewNRGBA(image.Rect(0, 0, imageWidth, imageHeight))
	// Fill image with blue to help with debugging.
	//imageFill(myImage, color.NRGBA{B: 255, A: 225})

	cb := getComputeBounds(*xCenterFlag, *yCenterFlag, *scaleFlag, int(*maxIterFlag), imageWidth, imageHeight)
	ib := ImageBounds{xMax: imageWidth, yMax: imageHeight}
	computeImage(myImage, &cb, &ib, int(*nThreadsFlag))

	writeImageToDisk(myImage, *fileNameFlag)
}
