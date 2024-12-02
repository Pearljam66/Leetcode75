//
//  NearestExistEntranceMazeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/2/24.
//

/*
 You are given an m x n matrix maze (0-indexed) with empty cells (represented as '.') and walls (represented as '+'). You are also given the entrance of the maze, where entrance = [entrancerow, entrancecol] denotes the row and column of the cell you are initially standing at.
 In one step, you can move one cell up, down, left, or right. You cannot step into a cell with a wall, and you cannot step outside the maze. Your goal is to find the nearest exit from the entrance. An exit is defined as an empty cell that is at the border of the maze. The entrance does not count as an exit.
 Return the number of steps in the shortest path from the entrance to the nearest exit, or -1 if no such path exists.

 Example 1:
 Input: maze = [["+","+",".","+"],[".",".",".","+"],["+","+","+","."]], entrance = [1,2]
 Output: 1
 Explanation: There are 3 exits in this maze at [1,0], [0,2], and [2,3].
 Initially, you are at the entrance cell [1,2].
 - You can reach [1,0] by moving 2 steps left.
 - You can reach [0,2] by moving 1 step up.
 It is impossible to reach [2,3] from the entrance.
 Thus, the nearest exit is [0,2], which is 1 step away.

 Example 2:
 Input: maze = [["+","+","+"],[".",".","."],["+","+","+"]], entrance = [1,0]
 Output: 2
 Explanation: There is 1 exit in this maze at [1,2].
 [1,0] does not count as an exit since it is the entrance cell.
 Initially, you are at the entrance cell [1,0].
 - You can reach [1,2] by moving 2 steps right.
 Thus, the nearest exit is [1,2], which is 2 steps away.

 Example 3:
 Input: maze = [[".","+"]], entrance = [0,0]
 Output: -1
 Explanation: There are no exits in this maze.

 Constraints:
 maze.length == m
 maze[i].length == n
 1 <= m, n <= 100
 maze[i][j] is either '.' or '+'.
 entrance.length == 2
 0 <= entrancerow < m
 0 <= entrancecol < n
 entrance will always be an empty cell.
 */

import Testing

struct NearestExistEntranceMazeTest {

    class Solution {
        func nearestExit(_ maze: [[Character]], _ entrance: [Int]) -> Int {
            let rows = maze.count
            let cols = maze[0].count
            let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)] // right, down, left, up

            // Check if a position is valid and not a wall
            func isValidPosition(_ row: Int, _ col: Int) -> Bool {
                return row >= 0 && row < rows && col >= 0 && col < cols && maze[row][col] != "+"
            }

            // Check if the position is an exit
            func isExit(_ row: Int, _ col: Int) -> Bool {
                return (row == 0 || row == rows - 1 || col == 0 || col == cols - 1) && (row != entrance[0] || col != entrance[1])
            }

            // BFS queue with structure: [steps, row, col]
            var queue = [(0, entrance[0], entrance[1])]
            var visited = Set<String>()

            while !queue.isEmpty {
                let (steps, row, col) = queue.removeFirst()

                // If we've already visited this cell, skip
                let key = "\(row),\(col)"
                if visited.contains(key) { continue }
                visited.insert(key)

                // If we've found an exit, return the number of steps taken to get here
                if isExit(row, col) {
                    return steps
                }

                // Explore in all four directions
                for (dx, dy) in directions {
                    let newRow = row + dx
                    let newCol = col + dy
                    if isValidPosition(newRow, newCol) {
                        queue.append((steps + 1, newRow, newCol))
                    }
                }
            }

            // If we've exhausted all paths and found no exit
            return -1
        }
    }

    @Test func example1() {
        let maze: [[Character]] = [["+","+",".","+"],[".",".",".","+"],["+","+","+","."]]
        let entrance: [Int] = [1,2]
        let output: Int = 1

        #expect(Solution().nearestExit(maze, entrance) == output)
    }

    @Test func example2() {
        let maze: [[Character]] = [["+","+","+"],[".",".","."],["+","+","+"]]
        let entrance: [Int] = [1,0]
        let output: Int = 2

        #expect(Solution().nearestExit(maze, entrance) == output)
    }

    @Test func example3() {
        let maze: [[Character]] = [[".","+"]]
        let entrance: [Int] = [0,0]
        let output: Int = -1

        #expect(Solution().nearestExit(maze, entrance) == output)
    }

}
