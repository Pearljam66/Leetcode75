//
//  EqualRowAndColumnPairsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/1/24.
//

/*
 Given a 0-indexed n x n integer matrix grid, return the number of pairs (ri, cj) such that row ri and column cj are equal.
 A row and column pair is considered equal if they contain the same elements in the same order (i.e., an equal array).

 Example 1:
 Input: grid = [[3,2,1],[1,7,6],[2,7,7]]
 Output: 1
 Explanation: There is 1 equal row and column pair:
 - (Row 2, Column 1): [2,7,7]

 Example 2:
 Input: grid = [[3,1,2,2],[1,4,4,5],[2,4,2,2],[2,4,2,2]]
 Output: 3
 Explanation: There are 3 equal row and column pairs:
 - (Row 0, Column 0): [3,1,2,2]
 - (Row 2, Column 2): [2,4,2,2]
 - (Row 3, Column 2): [2,4,2,2]

 Constraints:
 n == grid.length == grid[i].length
 1 <= n <= 200
 1 <= grid[i][j] <= 105
 */

import Testing

struct EqualRowAndColumnPairsTest {

    class Solution {
        func equalPairs(_ grid: [[Int]]) -> Int {
            var rowMap = [String: Int]()
            let n = grid.count

            // Convert each row to a string key and store in the dictionary
            for row in grid {
                let rowKey = row.map { String($0) }.joined(separator: ",")
                rowMap[rowKey, default: 0] += 1
            }

            var count = 0

            // For each column, create a key similar to rows and check in the dictionary
            for j in 0..<n {
                var col = [String]()
                for i in 0..<n {
                    col.append(String(grid[i][j]))
                }
                let colKey = col.joined(separator: ",")
                count += rowMap[colKey, default: 0]
            }

            return count
        }

    }

    @Test func example1() {
        #expect(Solution().equalPairs([[3, 2, 1], [1, 7, 6], [2, 7, 7]]) == 1)
    }

    @Test func example2() {
        #expect(Solution().equalPairs([[3, 1, 2, 2], [1, 4, 4, 5], [2, 4, 2, 2], [2, 4, 2, 2]]) == 3)
    }

}
