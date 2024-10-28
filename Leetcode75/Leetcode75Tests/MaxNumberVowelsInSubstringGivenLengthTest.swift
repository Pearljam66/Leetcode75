//
//  MaxNumberVowelsInSubstringGivenLengthTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/28/24.
//

/*
 Given a string s and an integer k, return the maximum number of vowel letters in any substring of s with length k.
 Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

 Example 1:
 Input: s = "abciiidef", k = 3
 Output: 3
 Explanation: The substring "iii" contains 3 vowel letters.

 Example 2:
 Input: s = "aeiou", k = 2
 Output: 2
 Explanation: Any substring of length 2 contains 2 vowels.

 Example 3:
 Input: s = "leetcode", k = 3
 Output: 2
 Explanation: "lee", "eet" and "ode" contain 2 vowels.

 Constraints:
 1 <= s.length <= 105
 s consists of lowercase English letters.
 1 <= k <= s.length
 */

import Foundation
import Testing

struct MaxNumberVowelsInSubstringGivenLengthTest {

    class Solution {
        func maxVowels(_ s: String, _ k: Int) -> Int {
            let vowels: Set<Character> = Set("aeiou")

            // Convert string to array for easier manipulation
            let chars = Array(s)
            var count = 0
            var maxCount = 0

            // Count vowels in the first window
            for i in 0..<k {
                if vowels.contains(chars[i]) {
                    count += 1
                }
            }
            maxCount = count

            // Slide the window through the string
            for i in k..<chars.count {
                // Remove the vowel from the previous window if it exists
                if vowels.contains(chars[i - k]) {
                    count -= 1
                }
                // Add the vowel from the current character if it exists
                if vowels.contains(chars[i]) {
                    count += 1
                }
                // Update maxCount if current count is higher
                maxCount = max(maxCount, count)
            }

            return maxCount
        }
    }

    @Test func example1() {
        #expect(Solution().maxVowels("abciiidef", 3) == 3)
    }

    @Test func example2() {
        #expect(Solution().maxVowels("aeiou", 2) == 2)
    }

    @Test func example3() {
        #expect(Solution().maxVowels("leetcode", 3) == 2)
    }

}
