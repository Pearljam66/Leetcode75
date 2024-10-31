//
//  DetermineIfTwoStringsAreCloseTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/31/24.
//

/*
 Two strings are considered close if you can attain one from the other using the following operations:
 Operation 1: Swap any two existing characters.
 For example, abcde -> aecdb
 Operation 2: Transform every occurrence of one existing character into another existing character, and do the same with the other character.
 For example, aacabb -> bbcbaa (all a's turn into b's, and all b's turn into a's)
 You can use the operations on either string as many times as necessary.
 Given two strings, word1 and word2, return true if word1 and word2 are close, and false otherwise.

 Example 1:
 Input: word1 = "abc", word2 = "bca"
 Output: true
 Explanation: You can attain word2 from word1 in 2 operations.
 Apply Operation 1: "abc" -> "acb"
 Apply Operation 1: "acb" -> "bca"

 Example 2:
 Input: word1 = "a", word2 = "aa"
 Output: false
 Explanation: It is impossible to attain word2 from word1, or vice versa, in any number of operations.

 Example 3:
 Input: word1 = "cabbba", word2 = "abbccc"
 Output: true
 Explanation: You can attain word2 from word1 in 3 operations.
 Apply Operation 1: "cabbba" -> "caabbb"
 Apply Operation 2: "caabbb" -> "baaccc"
 Apply Operation 2: "baaccc" -> "abbccc"

 Constraints:
 1 <= word1.length, word2.length <= 105
 word1 and word2 contain only lowercase English letters.
 */

import Testing

struct DetermineIfTwoStringsAreCloseTest {

    class Solution {
        func closeStrings(_ word1: String, _ word2: String) -> Bool {
            // Check length first for efficiency.
            guard word1.count == word2.count else { return false }

            let frequency1 = word1.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
            let frequency2 = word2.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }

            // Check if they have the same set of characters
            if Set(word1) != Set(word2) {
                return false
            }

            // Check if the frequency count is the same, disregarding which character it belongs to
            let sortedCounts1 = frequency1.values.sorted()
            let sortedCounts2 = frequency2.values.sorted()
            if sortedCounts1 != sortedCounts2 {
                return false
            }

            // If we've made it here, the strings are close
            return true
        }
    }

    @Test func example1() {
        #expect(Solution().closeStrings("abc", "bca") == true)
    }

    @Test func example2() {
        #expect(Solution().closeStrings("a", "aa") == false)
    }

    @Test func example3() {
        #expect(Solution().closeStrings("cabbba", "abbccc") == true)
    }

}
