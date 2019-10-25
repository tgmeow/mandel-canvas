package mutexAdder

import "sync"

type LockableInt struct {
	v   int
	mux sync.Mutex
	wg  sync.WaitGroup
}

func adderThread(sum *LockableInt, count int) {
	defer sum.wg.Done()
	defer sum.mux.Unlock()

	sum.mux.Lock()
	for i := 0; i < count; i++ {
		sum.v++
	}
}

// Add to a single int across multiple threads using a mutex. Wait using WaitGroup.
func mutexAdder(nthreads int, threadIter int) int {
	var sum LockableInt
	for i := 0; i < nthreads; i++ {
		sum.wg.Add(1)
		go adderThread(&sum, threadIter)
	}
	sum.wg.Wait()
	return sum.v
}
