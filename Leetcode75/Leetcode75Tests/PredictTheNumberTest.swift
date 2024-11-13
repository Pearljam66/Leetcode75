//
//  PredictTheNumberTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/12/24.
//

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

import Foundation
import Testing

/*struct PredictTheNumberTest {

    class Solution {
        func findNthElement(_ nums: [Int]) -> Int {

            // Base case: if n is equal to 0, we return the initial element 0
            if nums.count == 0 {
                return 0
            }

            // Calculate the highest power of 2 less than or equal to n.
            let highestPowerOfTwo = Int(pow(2.0, Double(nums.count).log2))
            
            if nums <= highestPowerOfTwo {
                return nums[n]
            } else {
                
            }

        }
    }
}
*/
