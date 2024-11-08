//
//  MaximumTwinSumOfLinkedListTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/8/24.
//

/*
 In a linked list of size n, where n is even, the ith node (0-indexed) of the linked list is known as the twin of the (n-1-i)th node, if 0 <= i <= (n / 2) - 1.
 For example, if n = 4, then node 0 is the twin of node 3, and node 1 is the twin of node 2. These are the only nodes with twins for n = 4.
 The twin sum is defined as the sum of a node and its twin.
 Given the head of a linked list with even length, return the maximum twin sum of the linked list.

 Example 1:
 Input: head = [5,4,2,1]
 Output: 6
 Explanation:
 Nodes 0 and 1 are the twins of nodes 3 and 2, respectively. All have twin sum = 6.
 There are no other nodes with twins in the linked list.
 Thus, the maximum twin sum of the linked list is 6.

 Example 2:
 Input: head = [4,2,2,3]
 Output: 7
 Explanation:
 The nodes with twins present in this linked list are:
 - Node 0 is the twin of node 3 having a twin sum of 4 + 3 = 7.
 - Node 1 is the twin of node 2 having a twin sum of 2 + 2 = 4.
 Thus, the maximum twin sum of the linked list is max(7, 4) = 7.

 Example 3:
 Input: head = [1,100000]
 Output: 100001
 Explanation:
 There is only one node with a twin in the linked list having twin sum of 1 + 100000 = 100001.

 Constraints:
 The number of nodes in the list is an even integer in the range [2, 105].
 1 <= Node.val <= 105
 */

import Testing

struct MaximumTwinSumOfLinkedListTest {

    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }

    class Solution {
        func pairSum(_ head: ListNode?) -> Int {
            // Step 1: Find the middle of the linked list
            var slow = head
            var fast = head
            while fast != nil && fast?.next != nil {
                slow = slow?.next
                fast = fast?.next?.next
            }

            // Step 2: Reverse the second half of the linked list
            var prev: ListNode? = nil
            var current = slow
            while current != nil {
                let nextNode = current?.next
                current?.next = prev
                prev = current
                current = nextNode
            }

            // Step 3: Calculate twin sums and find the maximum
            var maxTwinSum = 0
            var firstHalf = head
            var secondHalf = prev
            while secondHalf != nil {
                if let firstVal = firstHalf?.val, let secondVal = secondHalf?.val {
                    let twinSum = firstVal + secondVal
                    maxTwinSum = max(maxTwinSum, twinSum)
                }
                firstHalf = firstHalf?.next
                secondHalf = secondHalf?.next
            }

            // Step 4: Return the maximum twin sum
            return maxTwinSum
        }
    }

    // Helper function to create a linked list from an array
    func createLinkedList(_ values: [Int]) -> ListNode? {
        guard !values.isEmpty else { return nil }
        let head = ListNode(values[0])
        var current = head
        for value in values.dropFirst() {
            current.next = ListNode(value)
            current = current.next!
        }
        return head
    }

    let solution = Solution()

    @Test func example1() {
        let head = createLinkedList([5, 4, 2, 1])
        let result = solution.pairSum(head)
        #expect(result == 6)
    }

    @Test func example2() {
        let head = createLinkedList([4, 2, 2, 3])
        let result = solution.pairSum(head)
        #expect(result == 7)
    }

    @Test func example3() {
        let head = createLinkedList([1, 100000])
        let result = solution.pairSum(head)
        #expect(result == 100001)
    }

}
