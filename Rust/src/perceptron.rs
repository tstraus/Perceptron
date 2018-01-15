extern crate rand;

mod neuron;

use rand::Rng;
use neuron::Neuron;

fn get_answer(inputs: &Vec<bool>) -> bool {
    let mut answer = inputs[0];
    for input in inputs {
        //answer = answer || *input; // learn to be an OR gate
        answer = answer && *input; // learn to be an AND gate
    }

    answer = !answer; // learn to be a NAND gate

    answer
}

fn main() {
    let num_inputs: u32 = 3;
    let reps = 600;

    let mut inputs: Vec<bool> = Vec::new();
    let mut results: Vec<bool> = Vec::new();

    let mut n = Neuron::new(num_inputs);
    let mut rng = rand::thread_rng();

    for _ in 0..reps {
        for _ in 0..num_inputs {
            inputs.push(rng.gen::<bool>());
        }

        let answer = get_answer(&inputs);
        results.push(n.train(&inputs, &answer));
        inputs.clear();
    }

    for result in results {
        println!("{}", result);
    }

    println!("---------------------------------");
    // OR gate
    //println!("correct: {}", n.forward_binary_check(&vec![false, false, false], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![false, false, true], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![false, true, false], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![false, true, true], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![true, false, false], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![true, false, true], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![true, true, false], &true));
    //println!("correct: {}", n.forward_binary_check(&vec![true, true, true], &true));

    // AND gate
    //println!("correct: {}", n.forward_binary_check(&vec![false, false, false], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![false, false, true], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![false, true, false], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![false, true, true], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![true, false, false], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![true, false, true], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![true, true, false], &false));
    //println!("correct: {}", n.forward_binary_check(&vec![true, true, true], &true));

    // NAND gate
    println!("correct: {}", n.forward_binary_check(&vec![false, false, false], &true));
    println!("correct: {}", n.forward_binary_check(&vec![false, false, true], &true));
    println!("correct: {}", n.forward_binary_check(&vec![false, true, false], &true));
    println!("correct: {}", n.forward_binary_check(&vec![false, true, true], &true));
    println!("correct: {}", n.forward_binary_check(&vec![true, false, false], &true));
    println!("correct: {}", n.forward_binary_check(&vec![true, false, true], &true));
    println!("correct: {}", n.forward_binary_check(&vec![true, true, false], &true));
    println!("correct: {}", n.forward_binary_check(&vec![true, true, true], &false));
}