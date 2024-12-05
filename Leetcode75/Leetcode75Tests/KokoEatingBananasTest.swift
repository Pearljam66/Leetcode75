//
//  KokoEatingBananasTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.
 Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.
 Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.
 Return the minimum integer k such that she can eat all the bananas within h hours.

 Example 1:
 Input: piles = [3,6,7,11], h = 8
 Output: 4

 Example 2:
 Input: piles = [30,11,23,4,20], h = 5
 Output: 30

 Example 3:
 Input: piles = [30,11,23,4,20], h = 6
 Output: 23

 Constraints:
 1 <= piles.length <= 104
 piles.length <= h <= 109
 1 <= piles[i] <= 109
 */

import Testing

struct KokoEatingBananasTest {

    class Solution {
        func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
            // Define the search space for k (the eating speed)
            var left = 1
            var right = piles.max() ?? 1  // Since we know there is at least one pile, max() will return a value

            while left < right {
                let k = left + (right - left) / 2  // Middle speed to test

                // Check if Koko can eat all bananas within h hours with speed k
                if canEatAll(piles, h, k) {
                    right = k  // Can eat, try to reduce speed (k)
                } else {
                    left = k + 1  // Can't eat all, increase speed
                }
            }

            return left  // left will be the minimum speed at the end
        }

        private func canEatAll(_ piles: [Int], _ h: Int, _ speed: Int) -> Bool {
            var hoursNeeded = 0

            for pile in piles {
                // Calculate hours needed to eat this pile
                hoursNeeded += (pile - 1) / speed + 1
                if hoursNeeded > h {
                    return false
                }
            }

            return hoursNeeded <= h
        }
    }

    @Test func example1() {
        let piles: [Int] = [3, 6, 7, 11]
        let h: Int = 8
        let expected: Int = 4
        #expect(Solution().minEatingSpeed(piles, h) == expected)
    }

    @Test func example2() {
        let piles: [Int] = [30, 11, 23, 4, 20]
        let h: Int = 5
        let expected: Int = 30
        #expect(Solution().minEatingSpeed(piles, h) == expected)
    }

    @Test func example3() {
        let piles: [Int] = [30, 11, 23, 4, 20]
        let h: Int = 6
        let expected: Int = 23
        #expect(Solution().minEatingSpeed(piles, h) == expected)
    }

}
