//
//  ReverseVowelsOfAString.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/24/24.
//

/*
 Given a string s, reverse only all the vowels in the string and return it.
 The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.

 Example 1:
 Input: s = "IceCreAm"
 Output: "AceCreIm"
 Explanation:
 The vowels in s are ['I', 'e', 'e', 'A']. On reversing the vowels, s becomes "AceCreIm".

 Example 2:
 Input: s = "leetcode"
 Output: "leotcede"

 Constraints:
 1 <= s.length <= 3 * 105
 s consist of printable ASCII characters.
 */

import Testing

struct ReverseVowelsOfAStringTest {

    class Solution {
        func reverseVowels(_ s: String) -> String {
            let vowels: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

            // Convert string to an array of characters for mutability
            var chars = Array(s)
            var left = 0
            var right = chars.count - 1

            while left < right {
                // Move left pointer until it points to a vowel
                while left < right && !vowels.contains(chars[left]) {
                    left += 1
                }

                // Move right pointer until it points to a vowel
                while left < right && !vowels.contains(chars[right]) {
                    right -= 1
                }

                // Swap the vowels
                if left < right {
                    chars.swapAt(left, right)
                    left += 1
                    right -= 1
                }
            }

            // Convert the array of characters back to a string
            return String(chars)
        }
    }

    @Test func example1() {
        #expect(Solution().reverseVowels("IceCreAm") == "AceCreIm")
    }

    @Test func example2() {
        #expect(Solution().reverseVowels("leetcode") == "leotcede")
    }

}
