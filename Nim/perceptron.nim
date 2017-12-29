# nim c -d:release perceptron.nim

import neuron, boolinator

let numInputs = 3
let reps = 600

var inputs = newSeq[bool](numInputs)
var results = newSeq[bool](reps)

var n = newNeuron(numInputs)

for i in 0..<reps:
    for input in 0..<numInputs:
        inputs[input] = nextBool()

    var answer = inputs[0]
    if numInputs > 0:
        for input in 0..<numInputs:
            #answer = answer or inputs[input] # learn to be an OR gate
            answer = answer and inputs[input] # learn to be an AND gate

        answer = not answer # learn to be a NAND gate

    results[i] = n.train(inputs, answer)

for result in results:
    echo result

echo "---------------------------------"
# OR gate
#echo "correct: ", n.forwardBinaryCheck(@[false, false, false], false)
#echo "correct: ", n.forwardBinaryCheck(@[false, false, true], true)
#echo "correct: ", n.forwardBinaryCheck(@[false, true, false], true)
#echo "correct: ", n.forwardBinaryCheck(@[false, true, true], true)
#echo "correct: ", n.forwardBinaryCheck(@[true, false, false], true)
#echo "correct: ", n.forwardBinaryCheck(@[true, false, true], true)
#echo "correct: ", n.forwardBinaryCheck(@[true, true, false], true)
#echo "correct: ", n.forwardBinaryCheck(@[true, true, true], true)

# AND gate
#echo "correct: ", n.forwardBinaryCheck(@[false, false, false], false)
#echo "correct: ", n.forwardBinaryCheck(@[false, false, true], false)
#echo "correct: ", n.forwardBinaryCheck(@[false, true, false], false)
#echo "correct: ", n.forwardBinaryCheck(@[false, true, true], false)
#echo "correct: ", n.forwardBinaryCheck(@[true, false, false], false)
#echo "correct: ", n.forwardBinaryCheck(@[true, false, true], false)
#echo "correct: ", n.forwardBinaryCheck(@[true, true, false], false)
#echo "correct: ", n.forwardBinaryCheck(@[true, true, true], true)

# NAND gate
echo "correct: ", n.forwardBinaryCheck(@[false, false, false], true)
echo "correct: ", n.forwardBinaryCheck(@[false, false, true], true)
echo "correct: ", n.forwardBinaryCheck(@[false, true, false], true)
echo "correct: ", n.forwardBinaryCheck(@[false, true, true], true)
echo "correct: ", n.forwardBinaryCheck(@[true, false, false], true)
echo "correct: ", n.forwardBinaryCheck(@[true, false, true], true)
echo "correct: ", n.forwardBinaryCheck(@[true, true, false], true)
echo "correct: ", n.forwardBinaryCheck(@[true, true, true], false)