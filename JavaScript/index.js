/* eslint-env node */

const chalk = require('chalk')
const Neuron = require('./neuron.js')

const numInputs = 2
const reps = 1000

let neuron = new Neuron(numInputs) // eslint-disable-line no-undef

let inputs = []
let results = []

for (let i = 0; i < reps; i++) {
  for (let i = 0; i < numInputs; i++) {
    inputs.push(Math.random() >= 0.5)
  }

  let answer = inputs[0]

  for (let i = 0; i < numInputs; i++) {
    // answer = answer || inputs[i] // learn to be an OR gate
    answer = answer && inputs[i] // learn to be an AND gate
  }

  // answer = !answer // NAND Gate

  results.push(neuron.train(inputs, answer))
  inputs = []
}

for (let i = 0; i < results.length; i++) {
  console.log('result: ' + results[i])
}

check(neuron, [0, 0], 0)
check(neuron, [0, 1], 0)
check(neuron, [1, 0], 0)
check(neuron, [1, 1], 1)

function check (neuron, inputs, answer) {
  if (neuron.forwardBinaryCheck(inputs, answer)) {
    console.log(inputs + ': ' + answer + ' => ' + chalk.green('correct'))
  } else {
    console.log(inputs + ': ' + answer + ' => ' + chalk.red('incorrect'))
  }
}
