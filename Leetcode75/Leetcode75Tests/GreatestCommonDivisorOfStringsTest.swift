//
//  GreatestCommonDivisorOfStringsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/22/24.
//

/*
 For two strings s and t, we say "t divides s" if and only if s = t + t + t + ... + t + t (i.e., t is concatenated with itself one or more times).
 Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

 Example 1:
 Input: str1 = "ABCABC", str2 = "ABC"
 Output: "ABC"

 Example 2:
 Input: str1 = "ABABAB", str2 = "ABAB"
 Output: "AB"

 Example 3:
 Input: str1 = "LEET", str2 = "CODE"
 Output: ""

 Constraints:
 1 <= str1.length, str2.length <= 1000
 str1 and str2 consist of English uppercase letters.
 */

import Testing

struct GreatestCommonDivisorOfStringsTest {

    class Solution {
        func gcdOfStrings(_ str1: String, _ str2: String) -> String {
            // If str1 + str2 is not equal to str2 + str1, then no common divisor string exists
            // This is because a common divisor would imply symmetry in concatenation
            if str1 + str2 != str2 + str1 {
                return ""
            }

            // Convert strings to arrays of characters for easier manipulation
            let chars1 = Array(str1)
            let chars2 = Array(str2)

            // Helper function to check if a string divides another
            func divides(_ divisor: [Character], _ dividend: [Character]) -> Bool {
                if dividend.count % divisor.count != 0 {
                    return false
                }
                let n = dividend.count / divisor.count
                return Array(repeating: divisor, count: n).flatMap { $0 } == dividend
            }

            // Use the Euclidean algorithm to find the greatest common divisor of the lengths
            func gcd(_ a: Int, _ b: Int) -> Int {
                return b == 0 ? a : gcd(b, a % b)
            }

            // Find the GCD of the lengths of the strings
            let gcdLength = gcd(chars1.count, chars2.count)

            // The largest string that divides both will be of length gcdLength or less
            for i in stride(from: gcdLength, through: 1, by: -1) {
                let potentialDivisor = Array(chars1.prefix(i))
                if divides(potentialDivisor, chars1) && divides(potentialDivisor, chars2) {
                    return String(potentialDivisor)
                }
            }

            return ""
        }
    }

    @Test func example1() {
        #expect(Solution().gcdOfStrings("ABCABC", "ABC") == "ABC")
    }

    @Test func example2() {
        #expect(Solution().gcdOfStrings("ABABAB", "ABAB") == "AB")
    }

    @Test func example3() {
        #expect(Solution().gcdOfStrings("LEET", "CODE") == "")
    }

}
