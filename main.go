package main

import (
	"./mandel"
	"bytes"
	"github.com/golang/protobuf/proto"
	"github.com/pkg/errors"
	"io/ioutil"
	"log"
	"net/http"
)

var client = &http.Client{}

const MandelUrl = "http://localhost:8080"

func main() {
	var dims int32 = 10
	cb := &mandel.DoubleRect{Xmin: -1.5, Xmax: 1, Ymin: -1, Ymax: 1,}
	ib := &mandel.IntRect{Xmin: 0, Xmax: dims, Ymin: 0, Ymax: dims,}

	mandReq := &mandel.MandelRequest{
		Cb: cb, Ib: ib,
		MaxIter: 100, ViewWidth: 10, ViewHeight: 10,
	}
	computation, err := computeMandelCloud(mandReq)
	if err != nil {
		// TODO handle error
		log.Panic("Compute Mandel Cloud failed: ", err)
	}
	log.Println(computation)
}

// Turns the MandelRequest into a MandelResponse by asking the cloud nicely
func computeMandelCloud(mandReq *mandel.MandelRequest) (*mandel.MandelResponse, error) {
	data, err := marshallMandelRequest(mandReq)
	if err != nil {
		return nil, err
	}
	//log.Println("Sending Request...", data)
	// Create and Send POST request to the remote
	resp, err := http.Post(MandelUrl, "application/octet-stream", bytes.NewBuffer(data))
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
