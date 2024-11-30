//
//  NumberOfProvincesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/30/24.
//

/*
 There are n cities. Some of them are connected, while some are not. If city a is connected directly with city b, and city b is connected directly with city c, then city a is connected indirectly with city c.
 A province is a group of directly or indirectly connected cities and no other cities outside of the group.
 You are given an n x n matrix isConnected where isConnected[i][j] = 1 if the ith city and the jth city are directly connected, and isConnected[i][j] = 0 otherwise.
 Return the total number of provinces.

 Example 1:
 Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
 Output: 2

 Example 2:
 Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
 Output: 3

 Constraints:
 1 <= n <= 200
 n == isConnected.length
 n == isConnected[i].length
 isConnected[i][j] is 1 or 0.
 isConnected[i][i] == 1
 isConnected[i][j] == isConnected[j][i]
 */

import Testing

struct NumberOfProvincesTest {

    class Solution {
        func findCircleNum(_ isConnected: [[Int]]) -> Int {
            let n = isConnected.count
            var visited = Set<Int>()
            var provinces = 0

            // Helper function for DFS
            func dfs(_ city: Int) {
                for neighbor in 0..<n {
                    if isConnected[city][neighbor] == 1 && !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        dfs(neighbor)  // Recursively visit connected cities
                    }
                }
            }

            // Iterate over all cities
            for city in 0..<n {
                if !visited.contains(city) {
                    dfs(city)   // Start a new province
                    provinces += 1  // Count this province
                }
            }

            return provinces
        }
    }

    @Test func example1() {
        #expect(Solution().findCircleNum([[1,1,0],[1,1,0],[0,0,1]]) == 2)
    }

    @Test func example2() {
        #expect(Solution().findCircleNum([[1,0,0],[0,1,0],[0,0,1]]) == 3)
    }

}
