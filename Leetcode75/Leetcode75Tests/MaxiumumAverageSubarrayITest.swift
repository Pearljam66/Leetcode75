//
//  MaxiumumAverageSubarrayITest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/27/24.
//

/*
 You are given an integer array nums consisting of n elements, and an integer k.
 Find a contiguous subarray whose length is equal to k that has the maximum average value and return this value. Any answer with a calculation error less than 10-5 will be accepted.

 Example 1:
 Input: nums = [1,12,-5,-6,50,3], k = 4
 Output: 12.75000
 Explanation: Maximum average is (12 - 5 - 6 + 50) / 4 = 51 / 4 = 12.75

 Example 2:
 Input: nums = [5], k = 1
 Output: 5.00000

 Example 3:
 Input: nums = [0,1,1,3,3], k = 4
 Output: 2.00000

 Constraints:
 n == nums.length
 1 <= k <= n <= 105
 -104 <= nums[i] <= 104
 */

import Testing

struct MaxiumumAverageSubarrayITest {

    class Solution {
        func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
            guard nums.count >= k else { return 0 }

            // Initial sum for the first window
            var sum = nums[0..<k].reduce(0, +)
            var maxAverage = Double(sum) / Double(k)

            // Sliding window
            for i in k..<nums.count {
                // Remove the first element of the previous window
                sum -= nums[i - k]
                // Add the next element of the new window
                sum += nums[i]
                // Calculate the new average
                let currentAverage = Double(sum) / Double(k)
                // Update maxAverage if necessary
                maxAverage = max(maxAverage, currentAverage)
            }
            return maxAverage
        }
    }

    @Test func example1() {
        #expect(Solution().findMaxAverage([1, 12, -5, -6, 50, 3], 4) == 12.75000)
    }

    @Test func example2() {
        #expect(Solution().findMaxAverage([5], 1) == 5.00000)
    }

    @Test func example3() {
        #expect(Solution().findMaxAverage([0, 1, 1, 3, 3], 4) == 2.00000)
    }

}
