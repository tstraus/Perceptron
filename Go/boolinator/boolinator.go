package boolinator

import (
	"math/rand"
	"time"
)

// Boolinator contains the variables needed to create random bools
type Boolinator struct {
	seed   rand.Source
	random *rand.Rand
}

// NewBoolinator is the Boolinator constructor
func NewBoolinator() *Boolinator {
	b := new(Boolinator)
	b.seed = rand.NewSource(time.Now().UnixNano())
	b.random = rand.New(b.seed)

	return b
}

// Bool generates a new bool each time called
func (b *Boolinator) Bool() bool {
	i := b.random.Intn(2)

	result := false
	if i == 1 {
		result = true
	}

	return result
}
