/* eslint-env node */

module.exports = class Neuron { // eslint-disable-line no-unused-vars
  constructor (numInputs) {
    this.threshold = 0.9
    this.learningRate = 0.01
    this.weights = []

    for (let i = 0; i < numInputs; i++) {
      this.weights.push(1 / numInputs)
    }
  }

  forward (inputs) {
    if (inputs instanceof Array && inputs.length === this.weights.length) {
      let sum = 0

      for (let i = 0; i < inputs.length; i++) {
        sum += inputs[i] * this.weights[i]
      }

      return Math.tanh(sum)
    }

    return -1
  }

  forwardBinary (inputs) {
    if (this.forward(inputs) > this.threshold) {
      return true
    }

    return false
  }

  forwardBinaryCheck (inputs, answer) {
    if (this.forwardBinary(inputs) === answer) {
      return true
    }

    return false
  }

  train (inputs, answer) {
    const result = this.forwardBinary(inputs)
    var delta = answer - result

    for (let i = 0; i < inputs.length; i++) {
      this.weights[i] += this.learningRate * delta * inputs[i]
    }

    this.threshold -= this.learningRate * delta

    if (result === answer) {
      return true
    }

    return false
  }
}
