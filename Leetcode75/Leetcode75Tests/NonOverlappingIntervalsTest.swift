//
//  NonOverlappingIntervalsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/18/24.
//

/*
 Given an array of intervals intervals where intervals[i] = [starti, endi], return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.
 Note that intervals which only touch at a point are non-overlapping. For example, [1, 2] and [2, 3] are non-overlapping.

 Example 1:
 Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
 Output: 1
 Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.

 Example 2:
 Input: intervals = [[1,2],[1,2],[1,2]]
 Output: 2
 Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.

 Example 3:
 Input: intervals = [[1,2],[2,3]]
 Output: 0
 Explanation: You don't need to remove any of the intervals since they're already non-overlapping.

 Constraints:
 1 <= intervals.length <= 105
 intervals[i].length == 2
 -5 * 104 <= starti < endi <= 5 * 104
 */

import Testing

struct NonOverlappingIntervalsTest {

    class Solution {

        // Returns the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.
        func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
            if intervals.isEmpty {
                return 0
            }

            // Sort intervals by end time
            let sortedIntervals = intervals.sorted { $0[1] < $1[1] }

            var nonOverlapEnd = sortedIntervals[0][1]
            var countToRemove = 0

            // Iterate through the sorted intervals starting from the second one
            for i in 1..<sortedIntervals.count {
                let currentStart = sortedIntervals[i][0]
                let currentEnd = sortedIntervals[i][1]

                // If the current interval overlaps with the last non-overlapping interval
                if currentStart < nonOverlapEnd {
                    // Increment the count of intervals to remove, but don't update nonOverlapEnd yet
                    countToRemove += 1
                } else {
                    // No overlap, update the end time of the last non-overlapping interval
                    nonOverlapEnd = currentEnd
                }
            }

            return countToRemove
        }

    }

    @Test func example1() {
        let input: [[Int]] = [[1, 2], [2, 3], [3, 4], [1, 3]]
        let expected: Int = 1
        #expect(Solution().eraseOverlapIntervals(input) == expected)
    }

    @Test func example2() {
        let input: [[Int]] = [[1, 2], [1, 2], [1, 2]]
        let expected: Int = 2
        #expect(Solution().eraseOverlapIntervals(input) == expected)
    }

    @Test func example3() {
        let input: [[Int]] = [[1, 2], [2, 3]]
        let expected: Int = 0
        #expect(Solution().eraseOverlapIntervals(input) == expected)
    }

    @Test func example4() {
        let input: [[Int]] = [[0,2],[1,3],[2,4],[3,5],[4,6]]
        let expected: Int = 2
        #expect(Solution().eraseOverlapIntervals(input) == expected)
    }
}
