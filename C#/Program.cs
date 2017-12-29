using System;
using System.Collections.Generic;

namespace PerceptronSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var rand = new Random();

            int numInputs = 2;
            ulong reps = 500;

            Neuron neuron = new Neuron(numInputs);

            var inputs = new List<bool>();
            var results = new List<bool>();

            for (ulong rep = 0; rep < reps; rep++)
            {
                for (int i = 0; i < numInputs; i++)
                    inputs.Add(rand.NextDouble() > 0.5);

                bool answer = inputs[0];
                if (numInputs > 0)
                {
                    for (int i = 0; i < numInputs; i++)
                        //answer = answer || inputs[i]; // OR Gate
                        answer = answer && inputs[i]; // AND Gate

                    answer = !answer; // NAND Gate
				}

                results.Add(neuron.Train(inputs, answer));
                inputs.Clear();
            }

            //foreach (var result in results)
                //Console.WriteLine($"result: {result}");

            //Console.WriteLine("---------------------------------");
			// OR Gate
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, false }, false));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, true }, true));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, false }, true));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, true }, true));

			// AND Gate
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, false }, false));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, true }, false));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, false }, false));
			//Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, true }, true));

			// NAND Gate
			Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, false }, true));
			Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { false, true }, true));
			Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, false }, true));
			Console.WriteLine("correct: " + neuron.ForwardBinaryCheck(new List<bool> { true, true }, false));
        }
    }
}
