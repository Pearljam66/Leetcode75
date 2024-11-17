//
//  main.swift
//  Interview
//
//  Created by Sarah Clark on 11/15/24.
//


import Foundation

    /*
     Practice Question:
     Square a Number.
     Write a program that squares an integer and prints the result.
     For each line of input, print to standard output the square of the number. Print out each result on a new line.
     Your program should read lines from standard input. Each line will contain a positive integer.

     Test case 1:
     25

     Test case 2:
     625
     */

    enum SquareError: Error {
        case invalidInput
    }

    func squareNumber(_ input: String) throws -> Int {
        guard let number = Int(input) else {
            throw SquareError.invalidInput
        }
        return number * number
    }

    func processInput() {
        while let input = readLine() {
            do {
                let result = try squareNumber(input)
                print("Your number squared is:\(result)")
            } catch {
                print("Error: Please enter a valid integer")
            }
        }
    }

/*
 Predict the Number
 Description:
 The example sequence 011212201220200112 … is constructed as follows:
 1. The first element in the sequence is 0.
 2. For each iteration, repeat the following action: take a copy of the entire current sequence, replace 0 with 1, 1 with 2, and 2 with 0, and place it at the end of the current sequence.
 E.g. 001011201121220

 Create an algorithm which determines what number is at the Nth position in the sequence (using 0-based indexing).

 Input: Your program should read lines from standard input.
 Each line contains an integer N such that 0 <= N <= 3000000000.

 Output: Print out the number which is at the Nth position in the sequence.

 Test Case 1
 Input: N = 0
 Explanation: The sequence starts with 0, so the 0th element is 0.
 Expected Output: 0

 Test Case 2
 Input: N = 3
 Explanation: The sequence up to the 3rd position is 0 -> 01 -> 0112 -> 01121220. The element at the 3rd position is 2.
 Expected Output: 2

 Test Case 3
 Input: N = 10
 Explanation: The sequence continues to expand as 0 -> 01 -> 0112 -> 01121220 -> 0112122012202001 -> .... Following this expansion, we find that the 10th element in the sequence is 2.
 Expected Output: 2
 */

// This function finds the number at the given position in the sequence.
func predictNumber(at position: Int) -> Int {
    // Base case: The first number in the sequence is 0.
    if position == 0 { return 0 }

    // Determine the number at the given position by tracing back the transformations
    var currentPosition = position
    var currentNumber = 0

    while currentPosition > 0 {
        // Find the largest power of 2 less than or equal to currentPosition
        var powerOfTwo = 1
        while powerOfTwo <= currentPosition {
            powerOfTwo *= 2
        }
        powerOfTwo /= 2

        // Determine the position within the current block
        let positionInBlock = currentPosition - powerOfTwo

        // Update the current number based on the transformation rules
        currentNumber = (currentNumber + 1) % 3

        // Move to the next position to check
        currentPosition = positionInBlock
    }

    return currentNumber
}

// Function to handle input and output, reads from the standard input.
func processNthElementInput() {
    // Start an infinite loop to keep reading input
    while true {
        // Attempt to read a line and convert it to an integer
        if let line = readLine(), let n = Int(line), n >= 0 {
            // If successful and non-negative, print the result of predictNumber for position n
            print("The number at position \(n) is: \(predictNumber(at: n))")
        } else {
            // If input isn't valid or negative, inform the user
            print("Please enter a valid number.")
        }
    }
}

// Practice problem
//print("Type in an input")
//processInput()

// Call the code.
print("Please enter a position number:")
processNthElementInput()
