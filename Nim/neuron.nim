import math

type Neuron* = ref object of RootObj
    threshold: float32
    learningRate: float32
    weights: seq[float32]

proc newNeuron*(numInputs: int): Neuron =
    result = Neuron(threshold: 0.9f, learningRate: 0.01f)
    result.weights = newSeq[float32](numInputs)

proc forward*(n: var Neuron, inputs: seq[bool]): float32 =
    result = -1.0f
    
    if inputs.len() == n.weights.len():
        var sum = 0.0f
        for i in 0..<inputs.len():
            var input = 0.0f
            if inputs[i]: input = 1.0f

            sum += input * n.weights[i]
        
        result = tanh(sum)

proc forwardBinary*(n: var Neuron, inputs: seq[bool]): bool =
    result = false

    if n.forward(inputs) > n.threshold:
        result = true

proc forwardBinaryCheck*(n: var Neuron, inputs: seq[bool], answer: bool): bool =
    result = false

    if n.forwardBinary(inputs) == answer:
        result = true

proc train*(n: var Neuron, inputs: seq[bool], answer: bool): bool =
    result = false

    if inputs.len() == n.weights.len():
        var answerVal = 0.0f
        if answer: answerVal = 1.0f

        let output = n.forwardBinary(inputs)
        var outputVal = 0.0f
        if output: outputVal = 1.0f

        for i in 0..<inputs.len():
            var input = 0.0f
            if inputs[i]: input = 1.0

            n.weights[i] += n.learningRate * (answerVal - outputVal) * input

        n.threshold -= n.learningRate * (answerVal - outputVal)

        if output == answer: result = true