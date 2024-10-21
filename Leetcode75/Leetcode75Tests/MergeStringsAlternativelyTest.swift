//
//  MergeStringsAlternativelyTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/21/24.
//

/*
 You are given two strings word1 and word2. Merge the strings by adding letters in alternating order, starting with word1.
 If a string is longer than the other, append the additional letters onto the end of the merged string.
 Return the merged string.

 Example 1:
 Input: word1 = "abc", word2 = "pqr"
 Output: "apbqcr"
 Explanation: The merged string will be merged as so:
 word1:  a   b   c
 word2:    p   q   r
 merged: a p b q c r

 Example 2:
 Input: word1 = "ab", word2 = "pqrs"
 Output: "apbqrs"
 Explanation: Notice that as word2 is longer, "rs" is appended to the end.
 word1:  a   b
 word2:    p   q   r   s
 merged: a p b q   r   s

 Example 3:
 Input: word1 = "abcd", word2 = "pq"
 Output: "apbqcd"
 Explanation: Notice that as word1 is longer, "cd" is appended to the end.
 word1:  a   b   c   d
 word2:    p   q
 merged: a p b q c   d

 Constraints:
 1 <= word1.length, word2.length <= 100
 word1 and word2 consist of lowercase English letters.
 */

import Testing

struct MergeStringsAlternativelyTest {

    class Solution {
        func mergeAlternately(_ word1: String, _ word2: String) -> String {
            var result = ""
            let chars1 = Array(word1)
            let chars2 = Array(word2)
            let maxLength = max(chars1.count, chars2.count)

            for i in 0..<maxLength {
                if i < chars1.count {
                    result.append(chars1[i])
                }
                if i < chars2.count {
                    result.append(chars2[i])
                }
            }
            return result
        }
    }

    @Test func example1() {
        #expect(Solution().mergeAlternately("abc", "pqr") == "apbqcr")
    }

    @Test func example2() {
        #expect(Solution().mergeAlternately("ab", "pqrs") == "apbqrs")
    }

    @Test func example3() {
        #expect(Solution().mergeAlternately("abcd", "pq") == "apbqcd")
    }

}
