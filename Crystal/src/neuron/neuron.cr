module Perceptron
  class Neuron
    def initialize(numInputs : Number)
      @threshold = 0.9
      @learningRate = 0.01
      @weights = [] of Float32

      numInputs.times do
        @weights << 0.3
      end
    end

    private def boolToFloat32(b : Bool) : Float32
      return b ? 1.0_f32 : 0.0_f32 
    end

    def forward(inputs : Array(Bool)) : Float32
      if inputs.size == @weights.size
        sum = 0.0_f32

        @weights.size.times do |i|
          sum += (boolToFloat32 inputs[i]) * @weights[i]
        end

        return Math.tanh(sum)
      end

      return -1.0_f32
    end

    def forwardBinary(inputs : Array(Bool)) : Bool
      if (forward inputs) > @threshold
        return true
      end

      return false
    end

    def forwardBinaryCheck(inputs : Array(Bool), answer : Bool)
      if (forwardBinary inputs) == answer
        return true
      end

      return false
    end

    def train(inputs : Array(Bool), answer : Bool) : Bool
      result = forwardBinary inputs
  
      fAnswer = boolToFloat32 answer
      fResult = boolToFloat32 result
      delta = fAnswer - fResult
  
      @weights.size.times do |i|
        @weights[i] += @learningRate * delta * (boolToFloat32 inputs[i])
      end
  
      @threshold -= @learningRate * delta
  
      return result == answer ? true : false
    end
  end
end