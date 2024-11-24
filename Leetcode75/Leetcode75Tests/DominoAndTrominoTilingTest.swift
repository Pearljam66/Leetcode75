//
//  DominoAndTrominoTilingTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/24/24.
//

/*
 You have two types of tiles: a 2 x 1 domino shape and a tromino shape. You may rotate these shapes.
 Given an integer n, return the number of ways to tile an 2 x n board. Since the answer may be very large, return it modulo 109 + 7.
 In a tiling, every square must be covered by a tile. Two tilings are different if and only if there are two 4-directionally adjacent cells on the board such that exactly one of the tilings has both squares occupied by a tile.

 Example 1:
 Input: n = 3
 Output: 5
 Explanation: The five different ways are show above.

 Example 2:
 Input: n = 1
 Output: 1

 Constraints:
 1 <= n <= 1000
 */

import Testing

struct DominoAndTrominoTilingTest {

    class Solution {
        func numTilings(_ n: Int) -> Int {
            let mod = 1_000_000_007

            // Base cases
            if n == 0 { return 0 }
            if n == 1 { return 1 }
            if n == 2 { return 2 }
            if n == 3 { return 5 }

            // Dynamic programming for n >= 4
            var dp = [Int](repeating: 0, count: n + 1)
            // Initial conditions
            dp[1] = 1
            dp[2] = 2
            dp[3] = 5

            // Compute for n >= 4
            for i in 4...n {
                dp[i] = (2 * dp[i-1] % mod + dp[i-3] % mod) % mod
            }

            return dp[n]
        }
    }

    @Test func example1() {
        #expect(Solution().numTilings(3) == 5)
    }

    @Test func example2() {
        #expect(Solution().numTilings(1) == 1)
    }

}
