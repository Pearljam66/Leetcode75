//
//  UniquePathsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/25/24.
//

/*
 There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.
 Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.
 The test cases are generated so that the answer will be less than or equal to 2 * 109.

 Example 1:
 Input: m = 3, n = 7
 Output: 28

 Example 2:
 Input: m = 3, n = 2
 Output: 3
 Explanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
 1. Right -> Down -> Down
 2. Down -> Down -> Right
 3. Down -> Right -> Down

 Constraints:
 1 <= m, n <= 100
 */

import Testing

struct UniquePathsTest {

    class Solution {

        /**
         Calculates the number of unique paths from the top-left corner to the bottom-right corner of an m x n grid.

         - Parameters:
         - m: Number of rows in the grid
         - n: Number of columns in the grid
         - Returns: Number of unique paths to the bottom-right corner
         */
        func uniquePaths(_ m: Int, _ n: Int) -> Int {
            // Create a 2D array initialized with 1's.
            // Each cell [i][j] represents the number of ways to reach this cell.
            var dp: [[Int]] = Array(repeating: Array(repeating: 1, count: n), count: m)

            // Fill the dp table.
            for i in 1..<m {
                for j in 1..<n {
                    // The number of ways to reach any cell is the sum of ways to reach this cell.
                    dp[i][j] = dp[i-1][j] + dp[i][j-1]
                }
            }

            // The bottom-right corner will contain the total number of paths.
            return dp[m-1][n-1]
        }
    }

    @Test func example1() {
        #expect(Solution().uniquePaths(3, 7) == 28)
    }

    @Test func example2() {
        #expect(Solution().uniquePaths(3, 2) == 3)
    }

}
