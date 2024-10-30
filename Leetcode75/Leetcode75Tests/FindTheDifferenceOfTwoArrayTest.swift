//
//  FindTheDifferenceOfTwoArrayTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/30/24.
//

/*
 Given two 0-indexed integer arrays nums1 and nums2, return a list answer of size 2 where:
 answer[0] is a list of all distinct integers in nums1 which are not present in nums2.
 answer[1] is a list of all distinct integers in nums2 which are not present in nums1.
 Note that the integers in the lists may be returned in any order.

 Example 1:
 Input: nums1 = [1,2,3], nums2 = [2,4,6]
 Output: [[1,3],[4,6]]
 Explanation:
 For nums1, nums1[1] = 2 is present at index 0 of nums2, whereas nums1[0] = 1 and nums1[2] = 3 are not present in nums2. Therefore, answer[0] = [1,3].
 For nums2, nums2[0] = 2 is present at index 1 of nums1, whereas nums2[1] = 4 and nums2[2] = 6 are not present in nums2. Therefore, answer[1] = [4,6].

 Example 2:
 Input: nums1 = [1,2,3,3], nums2 = [1,1,2,2]
 Output: [[3],[]]
 Explanation:
 For nums1, nums1[2] and nums1[3] are not present in nums2. Since nums1[2] == nums1[3], their value is only included once and answer[0] = [3].
 Every integer in nums2 is present in nums1. Therefore, answer[1] = [].

 Constraints:
 1 <= nums1.length, nums2.length <= 1000
 -1000 <= nums1[i], nums2[i] <= 1000
 */

import Testing

struct FindTheDifferenceOfTwoArrayTest {

    class Solution {
        func findDifference(_ nums1: [Int], _ nums2: [Int]) -> [[Int]] {
            // Convert arrays to sets for efficient look-up
            let set1 = Set(nums1)
            let set2 = Set(nums2)

            // Use filter to get the unique elements not present in the other set
            let onlyInNums1 = nums1.filter { !set2.contains($0) }.reduce(into: Set<Int>()) { set, element in
                set.insert(element)
            }
            let onlyInNums2 = nums2.filter { !set1.contains($0) }.reduce(into: Set<Int>()) { set, element in
                set.insert(element)
            }

            // Convert sets back to arrays for the answer
            return [Array(onlyInNums1), Array(onlyInNums2)]
        }
    }

    @Test func example1() {
        #expect(Solution().findDifference([1, 2, 3], [2, 4, 6]) == [[1, 3], [4, 6]])
    }

    @Test func example2() {
        #expect(Solution().findDifference([1, 2, 3, 3], [1, 1, 2, 2]) == [[3], []])
    }

}
