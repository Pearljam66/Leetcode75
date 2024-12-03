//
//  RottingOrangesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/3/24.
//

/*
 You are given an m x n grid where each cell can have one of three values:
 0 representing an empty cell,
 1 representing a fresh orange, or
 2 representing a rotten orange.
 Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.
 Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.

 Example 1:
 Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
 Output: 4

 Example 2:
 Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
 Output: -1
 Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.

 Example 3:
 Input: grid = [[0,2]]
 Output: 0
 Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.

 Constraints:
 m == grid.length
 n == grid[i].length
 1 <= m, n <= 10
 grid[i][j] is 0, 1, or 2.
 */

import Testing

struct RottingOrangesTest {

    class Solution {
        func orangesRotting(_ grid: [[Int]]) -> Int {
            let m = grid.count
            let n = grid[0].count
            var grid = grid  // Make a copy to modify without changing the input
            var freshOranges = 0
            var queue = Queue<(Int, Int)>()
            var time = 0

            // First pass to count fresh oranges and enqueue rotten ones
            for i in 0..<m {
                for j in 0..<n {
                    if grid[i][j] == 1 { freshOranges += 1 }
                    else if grid[i][j] == 2 { queue.enqueue((i, j)) }
                }
            }

            // Directions for adjacent cells
            let directions = [(1,0), (-1,0), (0,1), (0,-1)]

            // BFS to rot oranges
            while !queue.isEmpty && freshOranges > 0 {
                let size = queue.count
                for _ in 0..<size {
                    let (x, y) = queue.dequeue()!

                    for (dx, dy) in directions {
                        let newX = x + dx
                        let newY = y + dy

                        if newX >= 0 && newX < m && newY >= 0 && newY < n && grid[newX][newY] == 1 {
                            grid[newX][newY] = 2
                            freshOranges -= 1
                            queue.enqueue((newX, newY))
                        }
                    }
                }
                time += 1
            }

            // If there are still fresh oranges left, it's impossible to rot all
            return freshOranges == 0 ? time : -1
        }
    }

    // Queue implementation for Swift
    struct Queue<T> {
        private var elements: [T] = []

        mutating func enqueue(_ element: T) {
            elements.append(element)
        }

        mutating func dequeue() -> T? {
            return elements.removeFirst()
        }

        var isEmpty: Bool {
            return elements.isEmpty
        }

        var count: Int {
            return elements.count
        }
    }

    @Test func example1() {
        #expect(Solution().orangesRotting([[2, 1, 1], [1, 1, 0], [0, 1, 1]]) == 4)
    }

    @Test func example2() {
        #expect(Solution().orangesRotting([[2, 1, 1], [0, 1, 1], [1, 0, 1]]) == -1)
    }

    @Test func example3() {
        #expect(Solution().orangesRotting([[0, 2]]) == 0)
    }

}
