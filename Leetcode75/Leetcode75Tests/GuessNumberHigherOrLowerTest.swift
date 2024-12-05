//
//  GuessNumberHigherOrLowerTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 We are playing the Guess Game. The game is as follows:
 I pick a number from 1 to n. You have to guess which number I picked.
 Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.
 You call a pre-defined API int guess(int num), which returns three possible results:
 -1: Your guess is higher than the number I picked (i.e. num > pick).
 1: Your guess is lower than the number I picked (i.e. num < pick).
 0: your guess is equal to the number I picked (i.e. num == pick).
 Return the number that I picked.

 Example 1:
 Input: n = 10, pick = 6
 Output: 6

 Example 2:
 Input: n = 1, pick = 1
 Output: 1

 Example 3:
 Input: n = 2, pick = 1
 Output: 1

 Constraints:
 1 <= n <= 231 - 1
 1 <= pick <= n
 */

import Testing

struct GuessNumberHigherOrLowerTest {

    class Solution {
        private let pick: Int

        init(pick: Int) {
            self.pick = pick
        }

        func guessNumber(_ n: Int) -> Int {
            var left = 1
            var right = n
            while left <= right {
                let mid = left + (right - left) / 2
                switch guess(mid) {
                    case 0:
                        return mid
                    case 1:
                        left = mid + 1
                    case -1:
                        right = mid - 1
                    default:
                        fatalError("Unexpected guess result")
                }
            }
            return -1  // Error case
        }

        func guess(_ num: Int) -> Int {
            if num == pick {
                return 0
            } else if num > pick {
                return -1
            } else {
                return 1
            }
        }
    }

    @Test func example1() {
        let solution = Solution(pick: 6)
        #expect(solution.guessNumber(10) == 6)
    }

    @Test func example2() {
        let solution = Solution(pick: 1)
        #expect(solution.guessNumber(1) == 1)
    }

    @Test func example3() {
        let solution = Solution(pick: 1)
        #expect(solution.guessNumber(2) == 1)
    }
}
