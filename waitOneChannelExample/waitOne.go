package waitOneChannelExample

import (
	"fmt"
	"time"
)

func waitOneWorker(finished chan bool) {
	fmt.Println("Routine started.")
	time.Sleep(time.Second)
	fmt.Println("Routine Complete.")
	finished <- true
}

// Runs a thread and waits on it using a channel.
func waitOne() {
	fmt.Println("Starting one routine")

	finished := make(chan bool)
	go waitOneWorker(finished)

	fmt.Println("Waiting for one routine")
	<-finished
}
