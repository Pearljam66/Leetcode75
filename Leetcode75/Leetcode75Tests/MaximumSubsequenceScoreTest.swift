//
//  MaximumSubsequenceScoreTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 You are given two 0-indexed integer arrays nums1 and nums2 of equal length n and a positive integer k. You must choose a subsequence of indices from nums1 of length k.
 For chosen indices i0, i1, ..., ik - 1, your score is defined as:
 The sum of the selected elements from nums1 multiplied with the minimum of the selected elements from nums2.
 It can defined simply as: (nums1[i0] + nums1[i1] +...+ nums1[ik - 1]) * min(nums2[i0] , nums2[i1], ... ,nums2[ik - 1]).
 Return the maximum possible score.
 A subsequence of indices of an array is a set that can be derived from the set {0, 1, ..., n-1} by deleting some or no elements.

 Example 1:
 Input: nums1 = [1,3,3,2], nums2 = [2,1,3,4], k = 3
 Output: 12
 Explanation:
 The four possible subsequence scores are:
 - We choose the indices 0, 1, and 2 with score = (1+3+3) * min(2,1,3) = 7.
 - We choose the indices 0, 1, and 3 with score = (1+3+2) * min(2,1,4) = 6.
 - We choose the indices 0, 2, and 3 with score = (1+3+2) * min(2,3,4) = 12.
 - We choose the indices 1, 2, and 3 with score = (3+3+2) * min(1,3,4) = 8.
 Therefore, we return the max score, which is 12.

 Example 2:
 Input: nums1 = [4,2,3,1,1], nums2 = [7,5,10,9,6], k = 1
 Output: 30
 Explanation:
 Choosing index 2 is optimal: nums1[2] * nums2[2] = 3 * 10 = 30 is the maximum possible score.

 Constraints:
 n == nums1.length == nums2.length
 1 <= n <= 105
 0 <= nums1[i], nums2[j] <= 105
 1 <= k <= n
 */

import Testing

struct MaximumSubsequenceScoreTest {

    class Solution {

        func maxScore(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Int {
            // Pair nums1 and nums2 elements, sorting by nums2 in descending order
            let pairs = zip(nums1, nums2).sorted { $0.1 > $1.1 }

            var sum = 0
            var heap = Heap<Int>(sort: <) // Min-heap for nums1 values
            var result = 0

            for (num1, num2) in pairs {
                heap.insert(num1)
                sum += num1

                if heap.count > k {
                    if let smallest = heap.remove() {
                        sum -= smallest
                    }
                }

                if heap.count == k {
                    result = max(result, sum * num2)
                }
            }

            return result
        }

        // A simple heap implementation for this case
        struct Heap<T> {
            private(set) var elements: [T] = []
            private let sort: (T, T) -> Bool

            init(sort: @escaping (T, T) -> Bool) {
                self.sort = sort
            }

            var isEmpty: Bool {
                elements.isEmpty
            }

            var count: Int {
                elements.count
            }

            mutating func insert(_ element: T) {
                elements.append(element)
                sortUp(from: elements.count - 1)
            }

            mutating func remove() -> T? {
                guard !isEmpty else { return nil }

                elements.swapAt(0, elements.count - 1)
                let removed = elements.removeLast()
                sortDown(from: 0)

                return removed
            }

            private mutating func sortUp(from index: Int) {
                var childIndex = index
                var parentIndex = (childIndex - 1) / 2

                while childIndex > 0 && sort(elements[childIndex], elements[parentIndex]) {
                    elements.swapAt(childIndex, parentIndex)
                    childIndex = parentIndex
                    parentIndex = (childIndex - 1) / 2
                }
            }

            private mutating func sortDown(from index: Int) {
                var parentIndex = index

                while true {
                    let childIndex1 = parentIndex * 2 + 1
                    let childIndex2 = parentIndex * 2 + 2
                    var swapIndex = parentIndex

                    if childIndex1 < elements.count && sort(elements[childIndex1], elements[swapIndex]) {
                        swapIndex = childIndex1
                    }
                    if childIndex2 < elements.count && sort(elements[childIndex2], elements[swapIndex]) {
                        swapIndex = childIndex2
                    }

                    if swapIndex == parentIndex { return }

                    elements.swapAt(parentIndex, swapIndex)
                    parentIndex = swapIndex
                }
            }
        }
    }

    @Test func example1() {
        #expect(Solution().maxScore([1, 3, 3, 2], [2, 1, 3, 4], 3) == 12)
    }

    @Test func example2() {
        #expect(Solution().maxScore([4, 2, 3, 1, 1], [7, 5, 10, 9, 6], 1) == 30)
    }

}
