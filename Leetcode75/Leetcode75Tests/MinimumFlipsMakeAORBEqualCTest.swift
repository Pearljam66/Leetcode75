//
//  MinimumFlipsMakeAORBEqualCTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/9/24.
//

/*
 Given 3 positives numbers a, b and c. Return the minimum flips required in some bits of a and b to make ( a OR b == c ). (bitwise OR operation).
 Flip operation consists of change any single bit 1 to 0 or change the bit 0 to 1 in their binary representation.

 Example 1:
 Input: a = 2, b = 6, c = 5
 Output: 3
 Explanation: After flips a = 1 , b = 4 , c = 5 such that (a OR b == c)

 Example 2:
 Input: a = 4, b = 2, c = 7
 Output: 1

 Example 3:
 Input: a = 1, b = 2, c = 3
 Output: 0

 Constraints:
 1 <= a <= 10^9
 1 <= b <= 10^9
 1 <= c <= 10^9
 */

import Testing

struct MinimumFlipsMakeAORBEqualCTest {

    class Solution {
        func minFlips(_ a: Int, _ b: Int, _ c: Int) -> Int {
            var a = a
            var b = b
            var c = c
            var flips = 0

            while a > 0 || b > 0 || c > 0 {
                let aBit = a & 1
                let bBit = b & 1
                let cBit = c & 1

                if cBit == 1 {
                    // If c's bit is 1, we need at least one of a's or b's bits to be 1.
                    if aBit == 0 && bBit == 0 {
                        flips += 1
                    }
                } else {
                    // If c's bit is 0, both a's and b's bits should be 0.
                    flips += aBit + bBit
                }

                // Shift all numbers to the right by 1 to check the next bit.
                a >>= 1
                b >>= 1
                c >>= 1
            }

            return flips
        }
    }

    @Test func example1() {
        #expect(Solution().minFlips(2, 6, 5) == 3)
    }

    @Test func example2() {
        #expect(Solution().minFlips(4, 2, 7) == 1)
    }

    @Test func example3() {
        #expect(Solution().minFlips(1, 2, 3) == 0)
    }

}
