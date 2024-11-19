//
//  DailyTemperaturesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/19/24.
//

/*
 Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.

 Example 1:
 Input: temperatures = [73,74,75,71,69,72,76,73]
 Output: [1,1,4,2,1,1,0,0]

 Example 2:
 Input: temperatures = [30,40,50,60]
 Output: [1,1,1,0]

 Example 3:
 Input: temperatures = [30,60,90]
 Output: [1,1,0]

 Constraints:
 1 <= temperatures.length <= 105
 30 <= temperatures[i] <= 100
 */

import Testing

struct DailyTemperaturesTest {

    class Solution {
        func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
            let n = temperatures.count
            var result = Array(repeating: 0, count: n)
            var stack = [Int]() // Stack to store indices of temperatures

            for i in (0..<n).reversed() {
                // Pop from stack while current temperature is greater or equal
                while !stack.isEmpty && temperatures[i] >= temperatures[stack.last!] {
                    stack.removeLast()
                }

                // If stack is not empty, we've found the next warmer day
                if !stack.isEmpty {
                    result[i] = stack.last! - i
                }

                // Push the current index onto the stack
                stack.append(i)
            }

            return result
        }
    }

    @Test func example1() {
        #expect(Solution().dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]) == [1, 1, 4, 2, 1, 1, 0, 0])
    }

    @Test func example2() {
        #expect(Solution().dailyTemperatures([30, 40, 50, 60]) == [1, 1, 1, 0])
    }

    @Test func example3() {
        #expect(Solution().dailyTemperatures([30, 60, 90]) == [1, 1, 0])
    }

}
