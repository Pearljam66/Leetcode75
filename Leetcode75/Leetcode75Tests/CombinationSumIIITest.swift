//
//  CombinationSumIIITest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/21/24.
//

/*
 Find all valid combinations of k numbers that sum up to n such that the following conditions are true:
 Only numbers 1 through 9 are used.
 Each number is used at most once.
 Return a list of all possible valid combinations. The list must not contain the same combination twice, and the combinations may be returned in any order.

 Example 1:
 Input: k = 3, n = 7
 Output: [[1,2,4]]
 Explanation:
 1 + 2 + 4 = 7
 There are no other valid combinations.

 Example 2:
 Input: k = 3, n = 9
 Output: [[1,2,6],[1,3,5],[2,3,4]]
 Explanation:
 1 + 2 + 6 = 9
 1 + 3 + 5 = 9
 2 + 3 + 4 = 9
 There are no other valid combinations.

 Example 3:
 Input: k = 4, n = 1
 Output: []
 Explanation: There are no valid combinations.
 Using 4 different numbers in the range [1,9], the smallest sum we can get is 1+2+3+4 = 10 and since 10 > 1, there are no valid combination.

 Constraints:
 2 <= k <= 9
 1 <= n <= 60
 */

import Testing

struct CombinationSumIIITest {

    class Solution {
        func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
            var result: [[Int]] = []
            var combination: [Int] = []

            func backtrack(_ start: Int, _ sum: Int) {
                if combination.count == k {
                    if sum == n {
                        result.append(combination)
                    }
                    return
                }

                // If sum already exceeds n, stop this path
                if sum > n {
                    return
                }

                // Only continue if there are enough numbers left to reach k
                if combination.count + (10 - start) < k {
                    return
                }

                // Iterate up to 9 or until adding another number would exceed n
                for num in start...9 {
                    if sum + num <= n {
                        combination.append(num)
                        backtrack(num + 1, sum + num)
                        combination.removeLast()
                    } else {
                        // If adding this number would exceed n, there's no point in checking further numbers
                        break
                    }
                }
            }

            backtrack(1, 0)
            return result
        }
    }

    @Test func example1() {
        #expect(Solution().combinationSum3(3, 7) == [[1, 2, 4]])
    }

    @Test func example2() {
        #expect(Solution().combinationSum3(3, 9) == [[1, 2, 6], [1, 3, 5], [2, 3, 4]])
    }

    @Test func example3() {
        #expect(Solution().combinationSum3(4, 1) == [])
    }

}
