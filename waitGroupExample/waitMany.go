package waitGroupExample

import (
	"fmt"
	"sync"
	"time"
)

func manyWorker(waitGroup *sync.WaitGroup, id int) {
	defer waitGroup.Done()
	fmt.Printf("Worker %v: start\n", id)
	time.Sleep(time.Millisecond * 500)
	fmt.Printf("Worker %v: stop\n", id)
}

// Runs many threads, each running manyWorker. Waits on them using a WaitGroup.
func waitMany() {
	var waitGroup sync.WaitGroup

	for i := 0; i < 5; i++ {
		fmt.Println("Starting worker", i)
		waitGroup.Add(1)
		go manyWorker(&waitGroup, i)
	}

	fmt.Println("Waiting on many")
	waitGroup.Wait()
}
