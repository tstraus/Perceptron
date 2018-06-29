require "./neuron/*"

module Perceptron
  numInputs = 2
  reps = 500

  n = Neuron.new(numInputs)
  
  inputs = [] of Bool
  results = [] of Bool

  reps.times do 
    numInputs.times do
      inputs << (rand > 0.5)
    end

    answer = inputs[0]
    if numInputs > 0
      numInputs.times do |i|
        #answer = answer || inputs[i] # OR Gate
        answer = answer && inputs[i] # AND Gate
      end

      answer = !answer # NAND Gate
    end

    results << n.train(inputs, answer)
    inputs.clear
  end

  #results.size.times do |i|
    #puts results[i]
  #end

  #puts "---------------------------------"

  # OR Gate
  #puts n.forwardBinaryCheck [false, false], false
  #puts n.forwardBinaryCheck [false, true], true
  #puts n.forwardBinaryCheck [true, false], true
  #puts n.forwardBinaryCheck [true, true], true

  # AND Gate
  #puts n.forwardBinaryCheck [false, false], false
  #puts n.forwardBinaryCheck [false, true], false
  #puts n.forwardBinaryCheck [true, false], false
  #puts n.forwardBinaryCheck [true, true], true

  # NAND Gate
  puts n.forwardBinaryCheck [false, false], true
  puts n.forwardBinaryCheck [false, true], true
  puts n.forwardBinaryCheck [true, false], true
  puts n.forwardBinaryCheck [true, true], false
end
