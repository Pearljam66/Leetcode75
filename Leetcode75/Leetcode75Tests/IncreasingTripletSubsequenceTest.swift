//
//  IncreasingTripletSubsequenceTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/25/24.
//

/*
 Given an integer array nums, return true if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k]. If no such indices exists, return false.

 Example 1:
 Input: nums = [1,2,3,4,5]
 Output: true
 Explanation: Any triplet where i < j < k is valid.

 Example 2:
 Input: nums = [5,4,3,2,1]
 Output: false
 Explanation: No triplet exists.

 Example 3:
 Input: nums = [2,1,5,0,4,6]
 Output: true
 Explanation: The triplet (3, 4, 5) is valid because nums[3] == 0 < nums[4] == 4 < nums[5] == 6.

 Constraints:
 1 <= nums.length <= 5 * 105
 -231 <= nums[i] <= 231 - 1
 */

import Testing

struct IncreasingTripletSubsequenceTest {

    class Solution {
        func increasingTriplet(_ nums: [Int]) -> Bool {
            // If the array has less than 3 elements, it's impossible to form a triplet
            if nums.count < 3 {
                return false
            }

            var firstMin = Int.max
            var secondMin = Int.max

            for n in nums {
                // If we find a number smaller than or equal to firstMin,
                // update firstMin because this could be the start of a new potential triplet
                if n <= firstMin {
                    firstMin = n
                }
                // If we find a number that is greater than firstMin but smaller than or equal to secondMin,
                // we've found a potential middle number for our triplet
                else if n <= secondMin {
                    secondMin = n
                }
                // If we find a number greater than secondMin, we've found a valid triplet
                else {
                    return true  // n > secondMin > firstMin
                }
            }

            return false  // No triplet found
        }
    }

    @Test func example1() {
        #expect(Solution().increasingTriplet([1, 2, 3, 4, 5]))
    }

    @Test func example2() {
        #expect(!Solution().increasingTriplet([5, 4, 3, 2, 1]))
    }

    @Test func example3() {
        #expect(Solution().increasingTriplet([2, 1, 5, 0, 4, 6]))
    }

}
