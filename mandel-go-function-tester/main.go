package main

import (
	"./mandel"
	"bytes"
	"github.com/golang/protobuf/proto"
	"github.com/pkg/errors"
	"github.com/tgmeow/deferred-tic-toc"
	"image"
	"image/color"
	"image/png"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"
	"time"
)

var client = &http.Client{}

const MandelUrl = "http://104.196.204.230:80"

func main() {
	// First send a test request to wake the server and get the connection
	resp := sendDefaultSquareRequest(10)
	saveSampleImage(resp)

	const testCount = 20

	// Testing, get runtimes of each request with minimal interference
	testingDims := []int32{1, 10, 100, 500, 1000}
	for _, dims := range testingDims {
		for i := 0; i < testCount; i++ {
			time.Sleep(1000 * time.Millisecond)
			sendDefaultSquareRequest(dims)
		}
	}
	log.Println("Testing complete.")
}

func sendDefaultSquareRequest(dims int32) *mandel.MandelResponse {
	cb := &mandel.DoubleRect{Xmin: -1.5, Xmax: 1, Ymin: -1, Ymax: 1,}
	ib := &mandel.IntRect{Xmin: 0, Xmax: dims, Ymin: 0, Ymax: dims,}

	mandReq := &mandel.MandelRequest{
		Cb: cb, Ib: ib,
		MaxIter: 500, ViewWidth: dims, ViewHeight: dims,
	}
	print(strconv.Itoa(int(dims*dims)) + " ")
	resp, err := computeMandelCloud(mandReq)
	if err != nil {
		log.Println("Compute Mandel Cloud failed: ", err)
	} else {
		//log.Println("done")
		//log.Println(len(computation.Data))
	}
	return resp
}

func saveSampleImage(mandRes *mandel.MandelResponse) {
	iter := 0
	imgDims := image.Rect(0, 0, int(mandRes.Ib.Xmax), int(mandRes.Ib.Ymax))
	myImg := image.NewRGBA(imgDims)
	for y := 0; y < int(mandRes.Ib.Ymax); y++ {
		for x := 0; x < int(mandRes.Ib.Xmax); x++ {
			pixelColor := color.Gray{Y:uint8(float64(mandRes.Data[iter].NumIter*255)/float64(500))}
			myImg.Set(x, y, pixelColor)
			iter++
		}
	}
	outputFile, err := os.Create("mandel.png")
	if err != nil {
		log.Panic("Failed to create output file.", err)
	}
	err = png.Encode(outputFile, myImg)
	if err != nil {
		log.Panic("Failed to encode output file.", err)
	}

	err = outputFile.Close()
	if err != nil {
		log.Panic("Failed to close output file.", err)
	}
}

// Turns the MandelRequest into a MandelResponse by asking the cloud nicely
func computeMandelCloud(mandReq *mandel.MandelRequest) (*mandel.MandelResponse, error) {
    defer deferredTicToc.TicToc("computeMandelCloud")()
	data, err := marshallMandelRequest(mandReq)
	if err != nil {
		return nil, err
	}
	//log.Println("Sending Request...", data)
	// Create and Send POST request to the remote
	req, err := http.NewRequest("POST", MandelUrl, bytes.NewBuffer(data))
	if err != nil {
		return nil, err
	}
	// Set headers. octet-stream is REQUIRED. keep alive to try to reuse requests.
	req.Header.Set("Content-Type", "application/octet-stream")
	req.Header.Set("Connection", "Keep-Alive")
	req.Header.Set("Keep-Alive", "timeout=60, max=1000")

	// Send the http request.
	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}

	// Read body into Byte array
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	if resp.StatusCode != 200 {
		return nil, errors.New(resp.Status + ": " + string(body))
	}

	//log.Println("Received: ", body)
	return unmarshallMandelResponse(body)
}

// Marshalls a MandelRequest
func marshallMandelRequest(mandReq *mandel.MandelRequest) ([]byte, error) {
	data, err := proto.Marshal(mandReq)
	if err != nil {
		return nil, err
	}
	return data, nil
}

// Unmarshalls a Byte array into a MandelResponse
func unmarshallMandelResponse(data []byte) (*mandel.MandelResponse, error) {
	// Will hold the unmarshalled response
	recvProto := &mandel.MandelResponse{}
	// Try to unmarshall the response
	err := proto.Unmarshal(data, recvProto)
	if err != nil {
		return nil, err
	}
	return recvProto, nil
}
