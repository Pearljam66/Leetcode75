//
//  DeleteTheMiddleNodeOfALinkedListTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/5/24.
//

/*
 You are given the head of a linked list. Delete the middle node, and return the head of the modified linked list.
 The middle node of a linked list of size n is the ⌊n / 2⌋th node from the start using 0-based indexing, where ⌊x⌋ denotes the largest integer less than or equal to x.
 For n = 1, 2, 3, 4, and 5, the middle nodes are 0, 1, 1, 2, and 2, respectively.

 Example 1:
 Input: head = [1,3,4,7,1,2,6]
 Output: [1,3,4,1,2,6]
 Explanation:
 The above figure represents the given linked list. The indices of the nodes are written below.
 Since n = 7, node 3 with value 7 is the middle node, which is marked in red.
 We return the new list after removing this node.

 Example 2:
 Input: head = [1,2,3,4]
 Output: [1,2,4]
 Explanation:
 The above figure represents the given linked list.
 For n = 4, node 2 with value 3 is the middle node, which is marked in red.

 Example 3:
 Input: head = [2,1]
 Output: [2]
 Explanation:
 The above figure represents the given linked list.
 For n = 2, node 1 with value 1 is the middle node, which is marked in red.
 Node 0 with value 2 is the only node remaining after removing node 1.

 Constraints:
 The number of nodes in the list is in the range [1, 105].
 1 <= Node.val <= 105
 */

import Testing

struct DeleteTheMiddleNodeOfALinkedListTest {

    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next;
    }

        class Solution {
            func deleteMiddle(_ head: ListNode?) -> ListNode? {
                // If the list is empty or has only one node, return nil
                if head == nil || head?.next == nil {
                    return nil
                }

                // Use two pointers: slow and fast
                var slow = head
                var fast = head
                var prev: ListNode? = nil

                // Move fast pointer twice as fast as slow pointer
                while fast != nil && fast?.next != nil {
                    fast = fast?.next?.next
                    prev = slow
                    slow = slow?.next
                }

                // Delete the middle node
                prev?.next = slow?.next

                return head
            }
        }

        // Helper function to create a linked list from an array
        func createLinkedList(_ values: [Int]) -> ListNode? {
            let dummy = ListNode(0)
            var current = dummy
            for value in values {
                current.next = ListNode(value)
                current = current.next!
            }
            return dummy.next
        }

        // Helper function to convert a linked list to an array
        func linkedListToArray(_ head: ListNode?) -> [Int] {
            var result = [Int]()
            var current = head
            while current != nil {
                result.append(current!.val)
                current = current?.next
            }
            return result
        }

        @Test func testExample1() {
            let solution = Solution()
            let input = createLinkedList([1,3,4,7,1,2,6])
            let output = solution.deleteMiddle(input)
            let result = linkedListToArray(output)
            #expect(result == [1,3,4,1,2,6])
        }

        @Test func testExample2() {
            let solution = Solution()
            let input = createLinkedList([1,2,3,4])
            let output = solution.deleteMiddle(input)
            let result = linkedListToArray(output)
            #expect(result == [1,2,4])
        }

        @Test func testExample3() {
            let solution = Solution()
            let input = createLinkedList([2,1])
            let output = solution.deleteMiddle(input)
            let result = linkedListToArray(output)
            #expect(result == [2])
        }
    }
}
