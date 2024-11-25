//
//  LongestCommonSubsequenceTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/25/24.
//

/*
 Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.
 A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.
 For example, "ace" is a subsequence of "abcde".
 A common subsequence of two strings is a subsequence that is common to both strings.

 Example 1:
 Input: text1 = "abcde", text2 = "ace"
 Output: 3
 Explanation: The longest common subsequence is "ace" and its length is 3.

 Example 2:
 Input: text1 = "abc", text2 = "abc"
 Output: 3
 Explanation: The longest common subsequence is "abc" and its length is 3.

 Example 3:
 Input: text1 = "abc", text2 = "def"
 Output: 0
 Explanation: There is no such common subsequence, so the result is 0.

 Constraints:
 1 <= text1.length, text2.length <= 1000
 text1 and text2 consist of only lowercase English characters.
 */

import Testing

struct LongestCommonSubsequenceTest {

    class Solution {
        /**
         Finds the length of the longest common subsequence of two strings.

         - Parameters:
         - text1: The first string
         - text2: The second string
         - Returns: The length of the longest common subsequence
         */
        func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
            let s1 = Array(text1), s2 = Array(text2)
            let m = s1.count, n = s2.count

            // Initialize the dp table with one extra row and column for empty string cases
            var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

            // Build the dp table
            for i in 1...m {
                for j in 1...n {
                    if s1[i-1] == s2[j-1] {
                        // If characters match, add 1 to the length of LCS from the previous state
                        dp[i][j] = dp[i-1][j-1] + 1
                    } else {
                        // If characters don't match, take the maximum of LCS without including this character from either string
                        dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                    }
                }
            }

            // The bottom-right cell will contain the length of the LCS
            return dp[m][n]
        }
    }

    @Test func example1() {
        #expect(Solution().longestCommonSubsequence("abcde", "ace") == 3)
    }

    @Test func example2() {
        #expect(Solution().longestCommonSubsequence("abc", "abc") == 3)
    }

    @Test func example3() {
        #expect(Solution().longestCommonSubsequence("abc", "def") == 0)
    }

}
