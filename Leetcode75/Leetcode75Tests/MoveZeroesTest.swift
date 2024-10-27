//
//  MoveZeroesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/26/24.
//

/*
 Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 Note that you must do this in-place without making a copy of the array.

 Example 1:
 Input: nums = [0,1,0,3,12]
 Output: [1,3,12,0,0]

 Example 2:
 Input: nums = [0]
 Output: [0]

 Constraints:
 1 <= nums.length <= 104
 -231 <= nums[i] <= 231 - 1
 */

import Testing

struct MoveZeroesTest {

    class Solution {
        func moveZeroes(_ nums: inout [Int]) {
            // Index for placing non-zero elements
            var nonZeroIndex = 0

            // Traverse the array
            for i in 0..<nums.count {
                // If current element is non-zero
                if nums[i] != 0 {
                    // Swap current element with element at nonZeroIndex
                    if i != nonZeroIndex {
                        nums.swapAt(i, nonZeroIndex)
                    }
                    // Move index to the next position
                    nonZeroIndex += 1
                }
            }
        }
    }

    @Test func example1() {
        var nums: [Int] = [0, 1, 0, 3, 12]
        let expected: [Int] = [1, 3, 12, 0, 0]

        Solution().moveZeroes(&nums)

        #expect(nums == expected)
    }

    @Test func example2() {
        var nums: [Int] = [0]
        let expected: [Int] = [0]

        let solution = Solution()
        solution.moveZeroes(&nums)
        
        #expect(nums == expected)
    }

}
