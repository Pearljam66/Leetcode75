//
//  CountingBitsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/8/24.
//

/*
 Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1's in the binary representation of i.

 Example 1:
 Input: n = 2
 Output: [0,1,1]
 Explanation:
 0 --> 0
 1 --> 1
 2 --> 10

 Example 2:
 Input: n = 5
 Output: [0,1,1,2,1,2]
 Explanation:
 0 --> 0
 1 --> 1
 2 --> 10
 3 --> 11
 4 --> 100
 5 --> 101

 Constraints:
 0 <= n <= 105
 */

import Testing

struct CountingBitsTest {

    class Solution {
        func countBits(_ n: Int) -> [Int] {
            // Initialize an array to store the number of 1's for each number from 0 to n
            var ans = [Int](repeating: 0, count: n + 1)

            // Iterate over each number from 1 to n
            if n > 0 {
                for i in 1...n {
                    // Calculate the number of 1's using the relation:
                    // ans[i] = ans[i >> 1] + (i & 1)
                    ans[i] = ans[i >> 1] + (i & 1)
                }
            }
            return ans
        }
    }

    @Test func example1() {
        #expect(Solution().countBits(2) == [0, 1, 1])
    }

    @Test func example2() {
        #expect(Solution().countBits(5) == [0, 1, 1, 2, 1, 2])
    }

    @Test func example3() {
        #expect(Solution().countBits(0) == [0])
    }

}
