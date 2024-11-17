//
//  main.swift
//  Interview
//
//  Created by Sarah Clark on 11/15/24.
//


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

    // Practice problem
    /*print("Hello, World!")
     print("Type in an input")
     Solution().processInput()*/

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

    // Create an algorithm which determines what number is at the Nth position in the sequence (using 0-based indexing).
    // Input: Your program should read lines from standard input.
    // Output: Print out the number which is at the Nth position in the sequence.

    func predictNumber(at position: Int) -> Int {
        // If position is 0, return 0 as per the sequence start
        if position == 0 { return 0 }

        // Convert position to ternary without adding 1
        let ternary = convertToTernary(position)

        // Map the last digit to the sequence number
        // Here, we ensure that we're passing a Character to mapTernaryDigitToInt
        return mapTernaryDigitToInt(ternary.last ?? "0") % 3
    }

    /// Converts the given number to its ternary representation
    func convertToTernary(_ number: Int) -> [Character] {
        var ternary: [Character] = []
        var n = number

        while n > 0 {
            let remainder = n % 3
            ternary.insert(Character(String(remainder)), at: 0)
            n /= 3
        }

        return ternary
    }

    func mapTernaryDigitToInt(_ char: Character) -> Int {
        switch char {
            case "0": return 1 // 0 in ternary becomes 1 in our sequence
            case "1": return 2 // 1 in ternary becomes 2 in our sequence
            case "2": return 0 // 2 in ternary becomes 0 in our sequence
            default: return 0
        }
    }

    // Function to handle input and output
    func processNthElementInput() {
        if let line = readLine(), let n = Int(line) {
            print("The number at position \(n) is: \(predictNumber(at: n))")
        }
    }
}

// Create code for terminal.
print("Please enter a number:")
// 011212201220200112
Solution().processNthElementInput()

