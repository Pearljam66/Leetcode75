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

    // Convert the position to ternary (base 3) representation.
    // This is key because our sequence's pattern relates to ternary numbers
    let ternary = convertToTernary(position)

    // The last digit in the ternary representation determines the number in the sequence
    // Use the modulus operator to make sure we stay within the range 0, 1, 2
    return mapTernaryDigitToInt(ternary.last ?? "0") % 3
}

// Converts the given number to its ternary representation.
func convertToTernary(_ number: Int) -> [Character] {
    var ternary: [Character] = []
    // The number to convert
    var n = number

    // Loop until number becomes zero, building the ternary representation.
    while n > 0 {
        // Find the remainder when divided by 3, this is our ternary digit
        let remainder = n % 3
        // Insert this digit at the start of our array to get the correct order
        ternary.insert(Character(String(remainder)), at: 0)
        // Integer division by 3 to move to the next ternary digit
        n /= 3
    }

    // Returns an array of Characters representing the ternary digits.
    return ternary
}

// Maps a ternary digit to the corresponding sequence number.
func mapTernaryDigitToInt(_ char: Character) -> Int {
    switch char {
        case "0": return 1 // Ternary 0 maps to 1
        case "1": return 2 // Ternary 1 maps to 2
        case "2": return 0 // Ternary 2 maps to 0
        default: return 0 // Should not happen with valid ternary conversion
    }
}

// Function to handle input and output, reads from the standard input.
func processNthElementInput() {
    // Attempt to read a line and convert it to an integer
    if let line = readLine(), let n = Int(line) {
        // If successful, print the result of predictNumber for position n
        print("The number at position \(n) is: \(predictNumber(at: n))")
    }
}

// Practice problem
//print("Type in an input")
//processInput()

// Call the code.
print("Please enter a number:")
processNthElementInput()
