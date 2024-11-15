//
//  main.swift
//  Interview
//
//  Created by Sarah Clark on 11/15/24.
//

import Foundation

print("Hello, World!")

import Foundation

class Solution {

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
                print(result)
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

    // Function to get the digit at position n
    func findNthElement(_ n: Int) -> Int {
        // Base case
        if n == 0 { return 0 }

        // Find the power of 2 that gives us the block containing n
        var power = 0
        var blockSize = 1

        while blockSize <= n {
            blockSize *= 2
            power += 1
        }

        // Count transformations needed to reach n
        var result = 0
        var position = n

        while position > 0 {
            // Count how many complete transformations are needed
            let quotient = position / 3
            let remainder = position % 3

            // Update result based on remainder
            if remainder == 1 {
                result += 1
            } else if remainder == 2 {
                result += 2
            }

            position = quotient
        }

        // Return final digit after all transformations
        return result % 3
    }

    // Function to handle input and output
    func processNthElementInput() {
        while let line = readLine() {
            if let n = Int(line) {
                let solution = Solution()
                print(solution.findNthElement(n))
            }
        }
    }

}
