//
//  OddEvenLinkedListTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/6/24.
//

/*
 Given the head of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.
 The first node is considered odd, and the second node is even, and so on.
 Note that the relative order inside both the even and odd groups should remain as it was in the input.
 You must solve the problem in O(1) extra space complexity and O(n) time complexity.

 Example 1:
 Input: head = [1,2,3,4,5]
 Output: [1,3,5,2,4]

 Example 2:
 Input: head = [2,1,3,5,6,4,7]
 Output: [2,3,6,7,1,5,4]

 Constraints:
 The number of nodes in the linked list is in the range [0, 104].
 -106 <= Node.val <= 106
 */

import Testing

struct OddEvenLinkedListTest {

    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }

    class Solution {
        func oddEvenList(_ head: ListNode?) -> ListNode? {
            guard let head = head else {
                return nil
            }

            var odd = head
            var even = head.next
            let evenHead = even

            while even != nil && even?.next != nil {
                odd.next = even?.next
                odd = odd.next!
                even?.next = odd.next
                even = even?.next
            }

            odd.next = evenHead

            return head
        }
    }

    @Test func example1() {
        // Create the input linked list
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)

        // Call the oddEvenList function
        let result = Solution().oddEvenList(head)

        // Convert the resulting linked list to an array
        var resultArray = [Int]()
        var current = result
        while current != nil {
            resultArray.append(current!.val)
            current = current?.next
        }

        // Compare the resulting array with the expected output
        #expect(resultArray == [1, 3, 5, 2, 4])
    }

    @Test func example2() {
        // Create the input linked list
        let head = ListNode(2)
        head.next = ListNode(1)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(5)
        head.next?.next?.next?.next = ListNode(6)
        head.next?.next?.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next?.next?.next = ListNode(7)

        // Call the oddEvenList function
        let result = Solution().oddEvenList(head)

        // Convert the resulting linked list to an array
        var resultArray = [Int]()
        var current = result
        while current != nil {
            resultArray.append(current!.val)
            current = current?.next
        }

        // Compare the resulting array with the expected output
        #expect(resultArray == [2, 3, 6, 7, 1, 5, 4])
    }

}
