package neuron

import "math"

// Neuron is a multiple input single output neuron
type Neuron struct {
	threshold    float64
	learningRate float64
	weights      []float64
}

// NewNeuron is the constructor to Neuron
func NewNeuron(numInputs int) *Neuron {
	n := new(Neuron)
	n.threshold = 0.9
	n.learningRate = 0.01
	n.weights = make([]float64, numInputs)

	return n
}

// Forward calculates the output of the Neuron
func (n *Neuron) Forward(inputs []bool) float64 {
	if len(inputs) == len(n.weights) {
		sum := 0.0
		for i := 0; i < len(inputs); i++ {
			input := 0.0
			if inputs[i] {
				input = 1.0
			}

			sum += input * n.weights[i]
		}

		return math.Tanh(sum)
	}

	return -1.0
}

// ForwardBinary returns a bool of whether the Neuron broke its threshold
func (n *Neuron) ForwardBinary(inputs []bool) bool {
	if len(inputs) == len(n.weights) {
		if n.Forward(inputs) > n.threshold {
			return true
		}
	}

	return false
}

// ForwardBinaryCheck returns a bool of whether the Neuron's output was correct
func (n *Neuron) ForwardBinaryCheck(inputs []bool, answer bool) bool {
	if len(inputs) == len(n.weights) {
		result := n.ForwardBinary(inputs)

		if result == answer {
			return true
		}
	}

	return false
}

// Train trains the Neuron using the given inputs and answer
func (n *Neuron) Train(inputs []bool, answer bool) bool {
	if len(inputs) == len(n.weights) {
		answerVal := 0.0
		if answer {
			answerVal = 1.0
		}

		result := n.ForwardBinary(inputs)
		resultVal := 0.0
		if result {
			resultVal = 1.0
		}

		for i := 0; i < len(inputs); i++ {
			input := 0.0
			if inputs[i] {
				input = 1.0
			}

			n.weights[i] += n.learningRate * (answerVal - resultVal) * input
		}

		n.threshold -= n.learningRate * (answerVal - resultVal)

		if result == answer {
			return true
		}
	}

	return false
}
