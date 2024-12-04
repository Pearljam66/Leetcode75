//
//  TotalCostHireKWorkersTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 You are given a 0-indexed integer array costs where costs[i] is the cost of hiring the ith worker.
 You are also given two integers k and candidates. We want to hire exactly k workers according to the following rules:
 You will run k sessions and hire exactly one worker in each session.
 In each hiring session, choose the worker with the lowest cost from either the first candidates workers or the last candidates workers. Break the tie by the smallest index.
 For example, if costs = [3,2,7,7,1,2] and candidates = 2, then in the first hiring session, we will choose the 4th worker because they have the lowest cost [3,2,7,7,1,2].
 In the second hiring session, we will choose 1st worker because they have the same lowest cost as 4th worker but they have the smallest index [3,2,7,7,2]. Please note that the indexing may be changed in the process.
 If there are fewer than candidates workers remaining, choose the worker with the lowest cost among them. Break the tie by the smallest index.
 A worker can only be chosen once.
 Return the total cost to hire exactly k workers.

 Example 1:
 Input: costs = [17,12,10,2,7,2,11,20,8], k = 3, candidates = 4
 Output: 11
 Explanation: We hire 3 workers in total. The total cost is initially 0.
 - In the first hiring round we choose the worker from [17,12,10,2,7,2,11,20,8]. The lowest cost is 2, and we break the tie by the smallest index, which is 3. The total cost = 0 + 2 = 2.
 - In the second hiring round we choose the worker from [17,12,10,7,2,11,20,8]. The lowest cost is 2 (index 4). The total cost = 2 + 2 = 4.
 - In the third hiring round we choose the worker from [17,12,10,7,11,20,8]. The lowest cost is 7 (index 3). The total cost = 4 + 7 = 11. Notice that the worker with index 3 was common in the first and last four workers.
 The total hiring cost is 11.

 Example 2:
 Input: costs = [1,2,4,1], k = 3, candidates = 3
 Output: 4
 Explanation: We hire 3 workers in total. The total cost is initially 0.
 - In the first hiring round we choose the worker from [1,2,4,1]. The lowest cost is 1, and we break the tie by the smallest index, which is 0. The total cost = 0 + 1 = 1. Notice that workers with index 1 and 2 are common in the first and last 3 workers.
 - In the second hiring round we choose the worker from [2,4,1]. The lowest cost is 1 (index 2). The total cost = 1 + 1 = 2.
 - In the third hiring round there are less than three candidates. We choose the worker from the remaining workers [2,4]. The lowest cost is 2 (index 0). The total cost = 2 + 2 = 4.
 The total hiring cost is 4.

 Constraints:
 1 <= costs.length <= 105
 1 <= costs[i] <= 105
 1 <= k, candidates <= costs.length
 */

import Testing

struct TotalCostHireKWorkersTest {

    class Solution {
        func totalCost(_ costs: [Int], _ k: Int, _ candidates: Int) -> Int {
            // Create a min heap to store candidates
            var minHeap = Heap<(cost: Int, index: Int)> { $0.cost == $1.cost ? $0.index < $1.index : $0.cost < $1.cost }

            // Initialize pointers for the first and last candidates
            var next_head = candidates
            var next_tail = costs.count - 1 - candidates

            // Add first 'candidates' workers from both ends to the heap
            for i in 0..<candidates {
                minHeap.insert((costs[i], i))
            }

            for i in max(candidates, costs.count - candidates)..<costs.count {
                minHeap.insert((costs[i], i))
            }

            var totalCost = 0
            var hired = 0

            // Hire k workers
            while hired < k {
                // If heap is empty, break
                guard let (cost, index) = minHeap.remove() else { break }

                totalCost += cost
                hired += 1

                // If there are still workers to be considered
                if next_head <= next_tail {
                    if index < next_head {
                        // Add worker from head
                        minHeap.insert((costs[next_head], next_head))
                        next_head += 1
                    } else {
                        // Add worker from tail
                        minHeap.insert((costs[next_tail], next_tail))
                        next_tail -= 1
                    }
                }
            }

            return totalCost
        }
    }

    // Implementation of a min heap
    struct Heap<T> {
        var elements: [T] = []
        let priorityFunction: (T, T) -> Bool

        init(priorityFunction: @escaping (T, T) -> Bool) {
            self.priorityFunction = priorityFunction
        }

        mutating func insert(_ element: T) {
            elements.append(element)
            siftUp(from: elements.count - 1)
        }

        mutating func remove() -> T? {
            guard !elements.isEmpty else { return nil }

            if elements.count == 1 {
                return elements.removeLast()
            }

            let result = elements[0]
            elements[0] = elements.removeLast()
            siftDown(from: 0)

            return result
        }

        private mutating func siftUp(from index: Int) {
            var child = index
            var parent = parentIndex(of: child)

            while child > 0 && priorityFunction(elements[child], elements[parent]) {
                elements.swapAt(child, parent)
                child = parent
                parent = parentIndex(of: child)
            }
        }

        private mutating func siftDown(from index: Int) {
            var parent = index

            while true {
                let leftChild = leftChildIndex(of: parent)
                let rightChild = rightChildIndex(of: parent)
                var candidate = parent

                if leftChild < elements.count && priorityFunction(elements[leftChild], elements[candidate]) {
                    candidate = leftChild
                }

                if rightChild < elements.count && priorityFunction(elements[rightChild], elements[candidate]) {
                    candidate = rightChild
                }

                if candidate == parent {
                    return
                }

                elements.swapAt(parent, candidate)
                parent = candidate
            }
        }

        private func parentIndex(of index: Int) -> Int {
            return (index - 1) / 2
        }

        private func leftChildIndex(of index: Int) -> Int {
            return 2 * index + 1
        }

        private func rightChildIndex(of index: Int) -> Int {
            return 2 * index + 2
        }
    }

    @Test func example1() {
        let solution = Solution()
        #expect(solution.totalCost([17, 12, 10, 2, 7, 2, 11, 20, 8], 3, 4) == 11)
    }

    @Test func example2() {
        let solution = Solution()
        #expect(solution.totalCost([1, 2, 4, 1], 3, 3) == 4)
    }

}
