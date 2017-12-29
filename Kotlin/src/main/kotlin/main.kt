import java.util.Random

class Neuron()
{
    private var weights = arrayListOf<Double>()

    private var threshold = 0.9
    private val learningRate = 0.01

    constructor(numberOfInputs: Int) : this() {
        for (i in 1..numberOfInputs)
            weights.add(1.0 / numberOfInputs)
    }

    fun forward(inputs: ArrayList<Boolean>): Double
    {
        if (inputs.size == weights.size)
        {
            var sum = 0.0
            for (i in 0..(inputs.size - 1)) {
                val input = if (inputs[i]) 1.0 else 0.0
                sum += input * weights[i]
            }

            return Math.tanh(sum)
        }

        return -1.0
    }

    fun forwardBinary(inputs: ArrayList<Boolean>): Boolean
    {
        if (inputs.size == weights.size)
        {
            if (forward(inputs) > threshold)
                return true
        }

        return false
    }

    fun forwardBinaryCheck(inputs: ArrayList<Boolean>, answer: Boolean): Boolean
    {
        if (inputs.size == weights.size)
        {
            val result = forwardBinary(inputs)

            if (result == answer)
                return true
        }

        return false
    }

    fun train(inputs: ArrayList<Boolean>, answer: Boolean): Boolean
    {
        if (inputs.size == weights.size)
        {
            val answerVal = if (answer) 1.0 else 0.0
            val result = forwardBinary(inputs)
            val resultVal = if (result) 1.0 else 0.0

            for (i in 0..(inputs.size - 1)) {
                val input = if (inputs[i]) 1.0 else 0.0
                weights[i] += learningRate * (answerVal - resultVal) * input
            }

            threshold -= learningRate * (answerVal - resultVal)

            if (result == answer)
                return true
        }

        return false
    }
}

fun main(args: Array<String>)
{
    val numInputs = 3
    val reps = 1000
    val neuron = Neuron(numberOfInputs = numInputs)

    val inputs = arrayListOf<Boolean>()
    val results = arrayListOf<Boolean>()

    for (rep in 1..reps)
    {
        for (i in 0..(numInputs - 1))
            inputs.add(Random().nextBoolean())

        var answer = inputs[0]
        if (numInputs > 0)
        {
            for (i in 1 until numInputs)
                //answer = answer || inputs[i]; // learn to be an OR gate
                answer = answer && inputs[i] // learn to be an AND gate

            answer = !answer // learn to be a NAND gate
        }

        results.add(neuron.train(inputs, answer))
        inputs.clear()
    }

    for (result in results)
        println("result: $result")

    println("---------------------------------")
    // OR gate
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, false), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, true), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, false), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, true), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, false), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, true), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, false), true))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, true), true))

    // AND gate
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, false), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, true), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, false), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, true), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, false), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, true), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, false), false))
    //println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, true), true))

    // NAND gate
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, false), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, false, true), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, false), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(false, true, true), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, false), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, false, true), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, false), true))
    println("correct: " + neuron.forwardBinaryCheck(arrayListOf(true, true, true), false))
}