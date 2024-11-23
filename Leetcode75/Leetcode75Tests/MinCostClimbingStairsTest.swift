//
//  MinCostClimbingStairsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/23/24.
//

/*
 You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.
 You can either start from the step with index 0, or the step with index 1.
 Return the minimum cost to reach the top of the floor.

 Example 1:
 Input: cost = [10,15,20]
 Output: 15
 Explanation: You will start at index 1.
 - Pay 15 and climb two steps to reach the top.
 The total cost is 15.

 Example 2:
 Input: cost = [1,100,1,1,1,100,1,1,100,1]
 Output: 6
 Explanation: You will start at index 0.
 - Pay 1 and climb two steps to reach index 2.
 - Pay 1 and climb two steps to reach index 4.
 - Pay 1 and climb two steps to reach index 6.
 - Pay 1 and climb one step to reach index 7.
 - Pay 1 and climb two steps to reach index 9.
 - Pay 1 and climb one step to reach the top.
 The total cost is 6.

 Constraints:
 2 <= cost.length <= 1000
 0 <= cost[i] <= 999
 */

import Testing

struct MinCostClimbingStairsTest {

    class Solution {
        func minCostClimbingStairs(_ cost: [Int]) -> Int {
            // Handle edge cases
            guard cost.count >= 2 else { return 0 }

            // Base cases
            var prev = cost[0]
            var curr = cost[1]

            // Dynamic programming approach
            for i in 2..<cost.count {
                let next = cost[i] + min(prev, curr)
                prev = curr
                curr = next
            }

            // The cost to reach the top (one step above the last element)
            return min(prev, curr)
        }
    }

    @Test func example1() {
        #expect(Solution().minCostClimbingStairs([10, 15, 20]) == 15)
    }

    @Test func example2() {
        #expect(Solution().minCostClimbingStairs([1,100,1,1,1,100,1,1,100,1]) == 6)
    }

}
