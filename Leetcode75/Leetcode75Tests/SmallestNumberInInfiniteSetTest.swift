//
//  SmallestNumberInInfiniteSetTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 You have a set which contains all positive integers [1, 2, 3, 4, 5, ...].
 Implement the SmallestInfiniteSet class:
 SmallestInfiniteSet() Initializes the SmallestInfiniteSet object to contain all positive integers.
 int popSmallest() Removes and returns the smallest integer contained in the infinite set.
 void addBack(int num) Adds a positive integer num back into the infinite set, if it is not already in the infinite set.

 Example 1:
 Input
 ["SmallestInfiniteSet", "addBack", "popSmallest", "popSmallest", "popSmallest", "addBack", "popSmallest", "popSmallest", "popSmallest"]
 [[], [2], [], [], [], [1], [], [], []]
 Output
 [null, null, 1, 2, 3, null, 1, 4, 5]

 Explanation
 SmallestInfiniteSet smallestInfiniteSet = new SmallestInfiniteSet();
 smallestInfiniteSet.addBack(2);    // 2 is already in the set, so no change is made.
 smallestInfiniteSet.popSmallest(); // return 1, since 1 is the smallest number, and remove it from the set.
 smallestInfiniteSet.popSmallest(); // return 2, and remove it from the set.
 smallestInfiniteSet.popSmallest(); // return 3, and remove it from the set.
 smallestInfiniteSet.addBack(1);    // 1 is added back to the set.
 smallestInfiniteSet.popSmallest(); // return 1, since 1 was added back to the set and
 // is the smallest number, and remove it from the set.
 smallestInfiniteSet.popSmallest(); // return 4, and remove it from the set.
 smallestInfiniteSet.popSmallest(); // return 5, and remove it from the set.

 Constraints:
 1 <= num <= 1000
 At most 1000 calls will be made in total to popSmallest and addBack.
 */

import Testing

struct SmallestNumberInInfiniteSetTest {

    class SmallestInfiniteSet {
        // Set to keep track of numbers that have been popped
        private var poppedNumbers: Set<Int> = Set()
        // The current smallest number available in the infinite set
        private var currentSmallest: Int = 1

        init() {}

        /// Removes and returns the smallest integer in the set.
        /// - Returns: The smallest integer that was removed from the set.
        func popSmallest() -> Int {
            if let smallestPopped = poppedNumbers.min() {
                // If there are popped numbers, return the smallest one
                poppedNumbers.remove(smallestPopped)
                return smallestPopped
            } else {
                // Otherwise, return the next smallest integer
                defer { currentSmallest += 1 }
                return currentSmallest
            }
        }

        /// Adds a number back into the set if it's not already present.
        /// - Parameter num: The number to add back into the set.
        func addBack(_ num: Int) {
            if num < currentSmallest {
                poppedNumbers.insert(num)
            }
        }
    }

    @Test func example1() {
        let smallestInfiniteSet = SmallestInfiniteSet()
        smallestInfiniteSet.addBack(2)
        #expect(smallestInfiniteSet.popSmallest() == 1)
        #expect(smallestInfiniteSet.popSmallest() == 2)
        #expect(smallestInfiniteSet.popSmallest() == 3)
        smallestInfiniteSet.addBack(1)
        #expect(smallestInfiniteSet.popSmallest() == 1)
        #expect(smallestInfiniteSet.popSmallest() == 4)
        #expect(smallestInfiniteSet.popSmallest() == 5)
    }

}
