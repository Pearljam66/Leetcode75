//
//  AsteroidCollisionTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/2/24.
//

/*
 We are given an array asteroids of integers representing asteroids in a row.
 For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.
 Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.

 Example 1:
 Input: asteroids = [5,10,-5]
 Output: [5,10]
 Explanation: The 10 and -5 collide resulting in 10. The 5 and 10 never collide.

 Example 2:
 Input: asteroids = [8,-8]
 Output: []
 Explanation: The 8 and -8 collide exploding each other.

 Example 3:
 Input: asteroids = [10,2,-5]
 Output: [10]
 Explanation: The 2 and -5 collide resulting in -5. The 10 and -5 collide resulting in 10.

 Constraints:
 2 <= asteroids.length <= 104
 -1000 <= asteroids[i] <= 1000
 asteroids[i] != 0
 */

import Testing

struct AsteroidCollisionTest {

    class Solution {
        func asteroidCollision(_ asteroids: [Int]) -> [Int] {
            var stack = [Int]()

            for asteroid in asteroids {
                var shouldAddAsteroid = true

                while shouldAddAsteroid && !stack.isEmpty && asteroid < 0 && stack.last! > 0 {
                    let last = stack.last!

                    if abs(last) < abs(asteroid) {
                        stack.removeLast() // The right-moving asteroid is smaller and explodes
                    } else if abs(last) == abs(asteroid) {
                        stack.removeLast() // Both asteroids are the same size and explode
                        shouldAddAsteroid = false
                    } else {
                        shouldAddAsteroid = false // The current asteroid explodes
                    }
                }

                if shouldAddAsteroid {
                    stack.append(asteroid) // Add the current asteroid to the stack if it survives
                }
            }

            return stack
        }

    }

    @Test func example1() {
        #expect(Solution().asteroidCollision([5, 10, -5]) == [5, 10])
    }

    @Test func example2() {
        #expect(Solution().asteroidCollision([8, -8]) == [])
    }

    @Test func example3() {
        #expect(Solution().asteroidCollision([10, 2, -5]) == [10])
    }

}
