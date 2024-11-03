//
//  DecodeStringTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/3/24.
//

/*
 Given an encoded string, return its decoded string.
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.
 You may assume that the input string is always valid; there are no extra white spaces, square brackets are well-formed, etc. Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there will not be input like 3a or 2[4].
 The test cases are generated so that the length of the output will never exceed 105.

 Example 1:
 Input: s = "3[a]2[bc]"
 Output: "aaabcbc"

 Example 2:
 Input: s = "3[a2[c]]"
 Output: "accaccacc"

 Example 3:
 Input: s = "2[abc]3[cd]ef"
 Output: "abcabccdcdcdef"

 Constraints:
 1 <= s.length <= 30
 s consists of lowercase English letters, digits, and square brackets '[]'.
 s is guaranteed to be a valid input.
 All the integers in s are in the range [1, 300].
 */

import Testing

struct DecodeStringTest {

    class Solution {
        func decodeString(_ s: String) -> String {
            var numStack = [Int]()
            var strStack = [String]()
            var currentString = ""
            var currentNum = 0

            for char in s {
                if let digit = char.wholeNumberValue {
                    // Build the number in case of multiple digits
                    currentNum = currentNum * 10 + digit
                } else if char == "[" {
                    // Push the current number and string onto their stacks
                    numStack.append(currentNum)
                    strStack.append(currentString)
                    // Reset current number and string
                    currentNum = 0
                    currentString = ""
                } else if char == "]" {
                    // Pop the multiplier and last string
                    if let repeatCount = numStack.popLast(), let lastString = strStack.popLast() {
                        currentString = lastString + String(repeating: currentString, count: repeatCount)
                    }
                } else {
                    // Build the current string
                    currentString.append(char)
                }
            }
            return currentString
        }

    }

    @Test func example1() {
        #expect(Solution().decodeString("3[a]2[bc]") == "aaabcbc")
    }

    @Test func example2() {
        #expect(Solution().decodeString("3[a2[c]]") == "accaccacc")
    }

    @Test func example3() {
        #expect(Solution().decodeString("2[abc]3[cd]ef") == "abcabccdcdcdef")
    }

}
