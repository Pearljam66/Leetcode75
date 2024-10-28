//
//  MaxConsecutiveOnesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/28/24.
//

/*
 Given a binary array nums and an integer k, return the maximum number of consecutive 1's in the array if you can flip at most k 0's.

 Example 1:
 Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
 Output: 6
 Explanation: [1,1,1,0,0,1,1,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.

 Example 2:
 Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
 Output: 10
 Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
 Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.

 Constraints:
 1 <= nums.length <= 105
 nums[i] is either 0 or 1.
 0 <= k <= nums.length
 */

import Testing

struct MaxConsecutiveOnesIIITest {

    class Solution {
        func longestOnes(_ nums: [Int], _ k: Int) -> Int {
            var maxConsecutiveOnes = 0
            var left = 0
            var zerosCount = 0

            for right in 0..<nums.count {
                // If current number is 0, increment zerosCount
                if nums[right] == 0 {
                    zerosCount += 1
                }

                // If number of zeros in the current window exceeds k,
                // we need to shrink the window from the left
                while zerosCount > k {
                    if nums[left] == 0 {
                        zerosCount -= 1
                    }
                    left += 1
                }

                // Update the max length of consecutive ones we can have
                maxConsecutiveOnes = max(maxConsecutiveOnes, right - left + 1)
            }

            return maxConsecutiveOnes
        }
    }

    @Test func example1() {
        let nums = [1,1,1,0,0,0,1,1,1,1,0]
        let k = 2
        let output = 6

        #expect(Solution().longestOnes(nums, k) == output)
    }

    @Test func example2() {
        let nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1]
        let k = 3
        let output = 10

        #expect(Solution().longestOnes(nums, k) == output)
    }

}
