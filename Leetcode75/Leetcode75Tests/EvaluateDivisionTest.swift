//
//  EvaluateDivisionTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/2/24.
//

/*
 You are given an array of variable pairs equations and an array of real numbers values, where equations[i] = [Ai, Bi] and values[i] represent the equation Ai / Bi = values[i].
 Each Ai or Bi is a string that represents a single variable.
 You are also given some queries, where queries[j] = [Cj, Dj] represents the jth query where you must find the answer for Cj / Dj = ?.
 Return the answers to all queries. If a single answer cannot be determined, return -1.0.
 Note: The input is always valid. You may assume that evaluating the queries will not result in division by zero and that there is no contradiction.
 Note: The variables that do not occur in the list of equations are undefined, so the answer cannot be determined for them.

 Example 1:
 Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]
 Output: [6.00000,0.50000,-1.00000,1.00000,-1.00000]
 Explanation:
 Given: a / b = 2.0, b / c = 3.0
 queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ?
 return: [6.0, 0.5, -1.0, 1.0, -1.0 ]
 note: x is undefined => -1.0

 Example 2:
 Input: equations = [["a","b"],["b","c"],["bc","cd"]], values = [1.5,2.5,5.0], queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]]
 Output: [3.75000,0.40000,5.00000,0.20000]

 Example 3:
 Input: equations = [["a","b"]], values = [0.5], queries = [["a","b"],["b","a"],["a","c"],["x","y"]]
 Output: [0.50000,2.00000,-1.00000,-1.00000]

 Constraints:
 1 <= equations.length <= 20
 equations[i].length == 2
 1 <= Ai.length, Bi.length <= 5
 values.length == equations.length
 0.0 < values[i] <= 20.0
 1 <= queries.length <= 20
 queries[i].length == 2
 1 <= Cj.length, Dj.length <= 5
 Ai, Bi, Cj, Dj consist of lower case English letters and digits.
 */

import Testing

struct EvaluateDivisionTest {

    class Solution {
        func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
            // Create a graph where each node is a variable and the edge weights are the values
            var graph = [String: [String: Double]]()

            // Build the graph
            for (i, equation) in equations.enumerated() {
                let (x, y) = (equation[0], equation[1])
                graph[x, default: [:]][y] = values[i]
                graph[y, default: [:]][x] = 1.0 / values[i] // Since x / y = value, y / x = 1 / value
            }

            // Helper function to perform DFS for finding the equation result
            func dfs(_ start: String, _ end: String, _ visited: inout Set<String>) -> Double {
                if start == end {
                    return 1.0 // If start is end, we've found our path with value 1
                }
                if let neighbors = graph[start] {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains(neighbor) {
                            visited.insert(neighbor)
                            let result = dfs(neighbor, end, &visited)
                            if result != -1.0 {
                                return weight * result
                            }
                            visited.remove(neighbor)
                        }
                    }
                }
                return -1.0 // No path found
            }

            // Process queries
            var results = [Double]()
            for query in queries {
                if let start = graph[query[0]], let end = graph[query[1]] {
                    var visited = Set<String>()
                    let result = dfs(query[0], query[1], &visited)
                    results.append(result)
                } else {
                    // If either of the variables in the query isn't in our graph
                    results.append(-1.0)
                }
            }

            return results
        }
    }

    @Test func example1() {
        let solution = Solution()
        let equations: [[String]] = [["a", "b"], ["b", "c"]]
        let values: [Double] = [2.0, 3.0]
        let queries: [[String]] = [["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"]]
        let output: [Double] = [6.0, 0.5, -1.0, 1.0, -1.0]

        #expect(solution.calcEquation(equations, values, queries) == output)
    }

    @Test func example2() {
        let solution = Solution()
        let equations: [[String]] = [["a", "b"], ["b", "c"], ["bc", "cd"]]
        let values: [Double] = [1.5, 2.5, 5.0]
        let queries: [[String]] = [["a", "c"], ["c", "b"], ["bc", "cd"], ["cd", "bc"]]
        let output: [Double] = [3.75, 0.4, 5, 0.2]

        #expect(solution.calcEquation(equations, values, queries) == output)
    }

    @Test func example3() {
        let solution = Solution()
        let equations: [[String]] = [["a", "b"]]
        let values: [Double] = [0.5]
        let queries: [[String]] = [["a", "b"], ["b", "a"], ["a", "c"], ["x", "y"]]
        let output: [Double] = [0.5, 2, -1, -1]

        #expect(solution.calcEquation(equations, values, queries) == output)
    }

}
