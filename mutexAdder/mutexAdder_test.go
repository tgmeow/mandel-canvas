package mutexAdder

import (
	"gotest.tools/assert"
	"testing"
)

func TestMutexAdder(t *testing.T) {
	nt, ti := 5, 1000
	expected := nt * ti
	for i := 0; i < 10; i++ {
		sum := mutexAdder(nt, ti)
		assert.Equal(t, sum, expected)
	}
}
