#ifndef __NEURON_H__
#define __NEURON_H__

#include <vector>
#include <tuple>

using namespace std;

class Neuron
{
public:
	Neuron(int numberOfInputs);

	~Neuron() {};

	double forward(vector<bool> inputs);

	bool forwardBinary(vector<bool> inputs);

	bool forwardBinaryCheck(vector<bool> inputs, bool answer);

	bool train(vector<bool> inputs, bool answers);

private:
	vector<double> weights; // input weights
	
	vector<Neuron> inputs; // for future backpropagation
	
	vector<Neuron> outputs; // for futude backpropagation

	double threshold; // trigger threshold

	double learningRate; //  how aggressive to tune the above values
};

#endif // __NEURON_H__
