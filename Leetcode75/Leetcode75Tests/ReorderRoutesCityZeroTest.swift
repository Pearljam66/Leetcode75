//
//  ReorderRoutesCityZeroTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/1/24.
//

/*
 There are n cities numbered from 0 to n - 1 and n - 1 roads such that there is only one way to travel between two different cities (this network forms a tree). Last year, The ministry of transport decided to orient the roads in one direction because they are too narrow.
 Roads are represented by connections where connections[i] = [ai, bi] represents a road from city ai to city bi.
 This year, there will be a big event in the capital (city 0), and many people want to travel to this city.
 Your task consists of reorienting some roads such that each city can visit the city 0. Return the minimum number of edges changed.
 It's guaranteed that each city can reach city 0 after reorder.

 Example 1:
 Input: n = 6, connections = [[0,1],[1,3],[2,3],[4,0],[4,5]]
 Output: 3
 Explanation: Change the direction of edges show in red such that each node can reach the node 0 (capital).

 Example 2:
 Input: n = 5, connections = [[1,0],[1,2],[3,2],[3,4]]
 Output: 2
 Explanation: Change the direction of edges show in red such that each node can reach the node 0 (capital).

 Example 3:
 Input: n = 3, connections = [[1,0],[2,0]]
 Output: 0

 Constraints:
 2 <= n <= 5 * 104
 connections.length == n - 1
 connections[i].length == 2
 0 <= ai, bi <= n - 1
 ai != bi
 */

import Testing

struct ReorderRoutesCityZeroTest {

    class Solution {
        func minReorder(_ n: Int, _ connections: [[Int]]) -> Int {

            // Create adjacency list for directed graph
            var graph = Array(repeating: [Int](), count: n)
            var edges = Set<String>()

            // Build the graph
            for connection in connections {
                let from = connection[0]
                let to = connection[1]
                graph[from].append(to) // Directed edge from -> to
                graph[to].append(from) // Add bidirectional unoriented edge for DFS traversal
                edges.insert("\(from),\(to)") // Keep track of directed edges
            }

            var visited = Set<Int>()
            var changes = 0

            // DFS to find how many edges need to be reversed
            func dfs(_ node: Int) {
                visited.insert(node)
                for next in graph[node] where !visited.contains(next) {
                    if edges.contains("\(node),\(next)") {
                        // This edge was originally pointing away from capital, so we need to reverse it
                        changes += 1
                    }
                    dfs(next)
                }
            }

            dfs(0) // Start DFS from the capital which is node 0

            return changes
        }
    }

    @Test func example1() {
        #expect(Solution().minReorder(6, [[0, 1], [1, 3], [2, 3], [4, 0], [4, 5]]) == 3)
    }

    @Test func example2() {
        #expect(Solution().minReorder(5, [[1, 0], [1, 2], [3, 2], [3, 4]]) == 2)
    }

    @Test func example3() {
        #expect(Solution().minReorder(3, [[1, 0], [2, 0]]) == 0)
    }

}
