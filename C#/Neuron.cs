using System;
using System.Collections.Generic;

namespace PerceptronSharp
{
    public class Neuron
    {
        public Neuron(int numInputs)
        {
            weights = new List<double>();
            for (int i = 0; i < numInputs; i++)
                weights.Add(1.0 / numInputs);

            threshold = 0.9;
            learningRate = 0.01;
        }

        public double Forward(List<bool> inputs)
        {
            if (inputs.Count == weights.Count)
            {
                double sum = 0.0;

                for (int i = 0; i < inputs.Count; i++)
                    sum += Convert.ToDouble(inputs[i]) * weights[i];

                return Math.Tanh(sum);
            }

            return -1;
        }

        public bool ForwardBinary(List<bool> inputs)
        {
            if (Forward(inputs) > threshold)
                return true;

            return false;
        }

        public bool ForwardBinaryCheck(List<bool> inputs, bool answer)
        {
            if (ForwardBinary(inputs) == answer)
                return true;

            return false;
        }

        public bool Train(List<bool> inputs, bool answer)
        {
            bool result = ForwardBinary(inputs);

            var dAnswer = Convert.ToDouble(answer);
            var dResult = Convert.ToDouble(result);
            var delta = dAnswer - dResult;

            for (int i = 0; i < inputs.Count; i++)
                weights[i] += learningRate * delta * Convert.ToDouble(inputs[i]);

            threshold -= learningRate * delta;

            if (result == answer)
                return true;

            return false;
        }

        public List<double> weights;

        private double threshold;

        private double learningRate;
    }
}
