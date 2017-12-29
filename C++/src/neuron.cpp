#include <iostream>
#include <math.h>

#include "neuron.h"

using namespace std;

Neuron::Neuron(int numberOfInputs)
{
	for (int i = 0; i < numberOfInputs; i++)
		weights.push_back(1.0 / numberOfInputs);

	threshold = 0.9;
	learningRate = 0.01;
}

double Neuron::forward(vector<bool> inputs)
{
	if (inputs.size() == weights.size())
	{
		double sum = 0.0;
		for (int i = 0; i < inputs.size(); i++)
			sum += inputs[i] * weights[i];

		return tanh(sum);
	}
	
	return -1;
}

bool Neuron::forwardBinary(vector<bool> inputs)
{
	if (inputs.size() == weights.size())
	{
		if (forward(inputs) > threshold)
			return true;
	}

	return false;
}

bool Neuron::forwardBinaryCheck(vector<bool> inputs, bool answer)
{
	if (inputs.size() == weights.size())
	{
		bool result = forwardBinary(inputs);

		if (result == answer)
			return true;
	}
	
	return false;
}

bool Neuron::train(vector<bool> inputs, bool answer)
{
	if (inputs.size() == weights.size())
	{
		bool result = forwardBinary(inputs);

		for (int i = 0; i < inputs.size(); i++)
			weights[i] += learningRate * ((double)answer - (double)result) * (double)inputs[i];

		threshold -= learningRate * ((double)answer - (double)result);

		/*for (int i = 0; i < weights.size(); i++)
			cout << "Weight " << i << ": " << weights[i] << "\n";
		cout << "Threshold: " << threshold << "\n";*/

		if (result == answer)
			return true;
	}

	return false;
}