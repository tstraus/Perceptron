package main

import (
	"fmt"

	"./boolinator"
	"./neuron"
)

func main() {
	numInputs := 3
	reps := 600

	inputs := make([]bool, numInputs)
	results := make([]bool, reps)

	n := neuron.NewNeuron(numInputs)
	b := boolinator.NewBoolinator()

	for i := 0; i < reps; i++ {
		for j := 0; j < numInputs; j++ {
			inputs[j] = b.Bool()
		}

		answer := inputs[0]
		if numInputs > 0 {
			for j := 0; j < numInputs; j++ {
				//answer = answer || inputs[j] // learn to be an OR gate
				answer = answer && inputs[j] // learn to be an AND gate
			}

			answer = !answer // learn to be a NAND gate
		}

		results[i] = n.Train(inputs, answer)
	}

	for _, e := range results {
		fmt.Println(e)
	}

	fmt.Println("---------------------------------")
	// OR gate
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, false}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, true}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, false}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, true}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, false}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, true}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, false}, true))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, true}, true))

	// AND gate
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, false}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, true}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, false}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, true}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, false}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, true}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, false}, false))
	//fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, true}, true))

	// NAND gate
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, false}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, false, true}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, false}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{false, true, true}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, false}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, false, true}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, false}, true))
	fmt.Println("correct: ", n.ForwardBinaryCheck([]bool{true, true, true}, false))
}
