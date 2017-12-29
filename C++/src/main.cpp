#include "neuron.h"
#include "json.hpp"

#include <iostream>
#include <fstream>
#include <chrono>
#include <random>

using namespace std;
using json = nlohmann::json;

int main(int argc, char** argv)
{
	ifstream file("Answers.json");
	json answers;
	file >> answers;

	unsigned int seed = (unsigned int)chrono::system_clock::now().time_since_epoch().count();
	default_random_engine engine(seed);
	uniform_int_distribution<unsigned int> rand(0, 1);

	int numInputs = 3;
	unsigned int reps = 1000;

	Neuron neuron(numInputs);

	vector<bool> inputs;
	inputs.reserve(numInputs);
	vector<bool> results;
	inputs.reserve(reps);

	for (unsigned int i = 0; i < reps; i++)
	{
		for (int i = 0; i < numInputs; i++)
			inputs.push_back(rand(engine) != 0);

		bool answer = inputs[0];
		if (numInputs > 0)
		{
			for (int i = 1; i < numInputs; i++)
				//answer = answer || inputs[i]; // learn to be an OR gate
				answer = answer && inputs[i]; // learn to be an AND gate

			answer = !answer; // learn to be a NAND gate
		}

		results.push_back(neuron.train(inputs, answer));
		inputs.clear();
	}

	for (auto& result : results)
		cout << "result:  " << result << "\n";

	cout << "---------------------------------" << endl;
	// OR gate
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 0, 0 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 0, 1 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 1, 0 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 1, 1 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 0, 0 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 0, 1 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 1, 0 }, true) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 1, 1 }, true) << endl;

	// AND gate
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 0, 0 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 0, 1 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 1, 0 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 0, 1, 1 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 0, 0 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 0, 1 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 1, 0 }, false) << endl;
	//cout << "correct: " << neuron.forwardBinaryCheck({ 1, 1, 1 }, true) << endl;

	// NAND gate
	cout << "check: " << neuron.forwardBinaryCheck({ 0, 0, 0 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 0, 0, 1 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 0, 1, 0 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 0, 1, 1 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 1, 0, 0 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 1, 0, 1 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 1, 1, 0 }, true) << endl;
	cout << "check: " << neuron.forwardBinaryCheck({ 1, 1, 1 }, false) << endl;

	return 0;
}