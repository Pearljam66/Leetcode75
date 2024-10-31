//
//  UniqueNumberOfOccurrancesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/31/24.
//

/*
 Given an array of integers arr, return true if the number of occurrences of each value in the array is unique or false otherwise.

 Example 1:
 Input: arr = [1,2,2,1,1,3]
 Output: true
 Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.

 Example 2:
 Input: arr = [1,2]
 Output: false

 Example 3:
 Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
 Output: true

 Constraints:
 1 <= arr.length <= 1000
 -1000 <= arr[i] <= 1000
 */

import Testing

struct UniqueNumberOfOccurrancesTest {

    class Solution {

        func uniqueOccurrences(_ arr: [Int]) -> Bool {
            // Step 1: Count occurrences of each number
            var occurrenceMap: [Int: Int] = [:]
            for num in arr {
                occurrenceMap[num, default: 0] += 1
            }

            // Step 2: Count the occurrences of occurrence numbers
            var uniqueOccurrences: Set<Int> = Set()
            for (_, count) in occurrenceMap {
                if uniqueOccurrences.contains(count) {
                    // If we find a duplicate count, return false
                    return false
                }
                uniqueOccurrences.insert(count)
            }

            // If we've made it here, all occurrence counts are unique
            return true
        }

    }

    @Test func example1() {
        #expect(Solution().uniqueOccurrences([1, 2, 2, 1, 1, 3]) == true)
    }

    @Test func example2() {
        #expect(Solution().uniqueOccurrences([1, 2]) == false)
    }

    @Test func example3() {
        #expect(Solution().uniqueOccurrences([-3,0,1,-3,1,1,1,-3,10,0]) == true)
    }

}
