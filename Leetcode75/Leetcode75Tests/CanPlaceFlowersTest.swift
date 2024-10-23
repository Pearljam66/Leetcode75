//
//  CanPlaceFlowersTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 10/23/24.
//

/*
 You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.
 Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.

 Example 1:
 Input: flowerbed = [1,0,0,0,1], n = 1
 Output: true

 Example 2:
 Input: flowerbed = [1,0,0,0,1], n = 2
 Output: false

 Constraints:
 1 <= flowerbed.length <= 2 * 104
 flowerbed[i] is 0 or 1.
 There are no two adjacent flowers in flowerbed.
 0 <= n <= flowerbed.length
 */

import Testing

struct CanPlaceFlowersTest {

    class Solution {
        func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
            var count = 0
            var mutableBed = flowerbed
            for i in 0..<mutableBed.count {
                // Check if the current spot and its adjacent spots are empty
                if mutableBed[i] == 0 {
                    let prevEmpty = (i == 0) || (mutableBed[i - 1] == 0)
                    let nextEmpty = (i == mutableBed.count - 1) || (mutableBed[i + 1] == 0)

                    if prevEmpty && nextEmpty {
                        // Plant a flower here
                        mutableBed[i] = 1
                        count += 1
                        // If we've planted enough flowers, we can return early
                        if count >= n {
                            return true
                        }
                    }
                }
            }
            // Check if we were able to plant n flowers
            return count >= n
        }
    }

    @Test func example1() {
            #expect(Solution().canPlaceFlowers([1,0,0,0,1], 1) == true)
    }

    @Test func example2() {
        #expect(Solution().canPlaceFlowers([1,0,0,0,1], 2) == false)
    }

}
