//
//  LongestSubarrayof1'sAfterDeletingOneElementTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/28/24.
//

/*
 Given a binary array nums, you should delete one element from it.
 Return the size of the longest non-empty subarray containing only 1's in the resulting array. Return 0 if there is no such subarray.

 Example 1:
 Input: nums = [1,1,0,1]
 Output: 3
 Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.

 Example 2:
 Input: nums = [0,1,1,1,0,1,1,0,1]
 Output: 5
 Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].

 Example 3:
 Input: nums = [1,1,1]
 Output: 2
 Explanation: You must delete one element.

 Constraints:
 1 <= nums.length <= 105
 nums[i] is either 0 or 1.
 */

import Testing

struct LongestSubarrayof1_sAfterDeletingOneElementTest {

    class Solution {
        func longestSubarray(_ nums: [Int]) -> Int {
            var maxOnes = 0
            var currentOnes = 0
            var previousOnes = 0

            for num in nums {
                if num == 1 {
                    currentOnes += 1
                } else {
                    maxOnes = max(maxOnes, previousOnes + currentOnes)
                    previousOnes = currentOnes
                    currentOnes = 0
                }
            }

            // Check if the last segment of 1's needs to be included
            maxOnes = max(maxOnes, previousOnes + currentOnes)

            return min(maxOnes, nums.count - 1)
        }
    }

    @Test func example1() {
        #expect(Solution().longestSubarray([1, 1, 0, 1]) == 3)
    }

    @Test func example2() {
        #expect(Solution().longestSubarray([0,1,1,1,0,1,1,0,1]) == 5)
    }

    @Test func example3() {
        #expect(Solution().longestSubarray([1,1,1]) == 2)
    }

}
