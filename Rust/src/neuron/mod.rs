fn bool_to_f64(b: &bool) -> f64 {
    if *b {
        1.0
    } else {
        0.0
    }
}

pub struct Neuron {
    threshold: f64,
    learning_rate: f64,
    weights: Vec<f64>,
}

impl Neuron {
    pub fn new(num_inputs: u32) -> Neuron {
        Neuron {
            threshold: 0.9,
            learning_rate: 0.01,
            weights: vec![0.0; num_inputs as usize],
        }
    }

    pub fn forward(&self, inputs: &Vec<bool>) -> f64 {
        if self.weights.len() == inputs.len() {
            let mut sum = 0.0;

            for i in 0..self.weights.len() {
                let input_value = bool_to_f64(&inputs[i]);

                sum += input_value * self.weights[i];
            }

            return sum.tanh();
        }

        0.0
    }

    pub fn forward_binary(&self, inputs: &Vec<bool>) -> bool {
        if self.forward(inputs) > self.threshold {
            return true;
        }

        false
    }

    pub fn forward_binary_check(&self, inputs: &Vec<bool>, answer: &bool) -> bool {
        let result = self.forward_binary(inputs);

        if result == *answer {
            return true;
        }

        false
    }

    pub fn train(&mut self, inputs: &Vec<bool>, answer: &bool) -> bool {
        let result = self.forward_binary(inputs);

        let answer_value = bool_to_f64(answer);
        let result_value = bool_to_f64(&result);

        for i in 0..self.weights.len() {
            let input = bool_to_f64(&inputs[i]);
            self.weights[i] += self.learning_rate * (answer_value - result_value) * input;
        }

        self.threshold -= self.learning_rate * (answer_value - result_value);

        if result == *answer {
            return true;
        }

        false
    }
}