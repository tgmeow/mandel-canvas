package main

import (
	"./mandel"
	"bytes"
	"github.com/golang/protobuf/proto"
	"github.com/pkg/errors"
	"image"
	"io/ioutil"
	//"log"
	"net/http"
)

var client = &http.Client{}

const MandelUrl = "http://104.196.204.230:80"

func makeRequest(cbounds *ComputeBounds64, ibA *image.Rectangle, size *image.Rectangle) (*mandel.MandelResponse, error) {
	//var dims int32 = 10
	cb := &mandel.DoubleRect{Xmin: cbounds.xMin, Xmax: cbounds.xMax, Ymin: cbounds.yMin, Ymax: cbounds.yMax,}
	ib := &mandel.IntRect{Xmin: int32(ibA.Min.X), Xmax: int32(ibA.Max.X), Ymin: int32(ibA.Min.Y), Ymax: int32(ibA.Max.Y),}

	mandReq := &mandel.MandelRequest{
		Cb: cb, Ib: ib,
		MaxIter: uint32(cbounds.maxIter), ViewWidth: int32(size.Max.X), ViewHeight: int32(size.Max.Y),
	}

	//log.Println(mandReq)
	computation, err := computeMandelCloud(mandReq)

	return computation, err
}

// Turns the MandelRequest into a MandelResponse by asking the cloud nicely
func computeMandelCloud(mandReq *mandel.MandelRequest) (*mandel.MandelResponse, error) {
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
