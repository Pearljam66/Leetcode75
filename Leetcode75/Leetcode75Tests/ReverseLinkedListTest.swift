//
//  ReverseLinkedListTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/6/24.
//

/*
 Given the head of a singly linked list, reverse the list, and return the reversed list.

 Example 1:
 Input: head = [1,2,3,4,5]
 Output: [5,4,3,2,1]

 Example 2:
 Input: head = [1,2]
 Output: [2,1]

 Example 3:
 Input: head = []
 Output: []

 Constraints:
 The number of nodes in the list is the range [0, 5000].
 -5000 <= Node.val <= 5000
 */

import Testing

struct ReverseLinkedListTest {

     public class ListNode {
         public var val: Int
         public var next: ListNode?
         public init() { self.val = 0; self.next = nil; }
         public init(_ val: Int) { self.val = val; self.next = nil; }
         public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
     }

    class Solution {
        func reverseList(_ head: ListNode?) -> ListNode? {
            var prev: ListNode? = nil
            var current = head

            while current != nil {
                let nextTemp = current?.next  // Store next node
                current?.next = prev          // Reverse the link
                prev = current               // Move prev one step forward
                current = nextTemp           // Move current one step forward
            }

            return prev
        }
    }

    let solution = Solution()

    @Test func example1() {
        let head1 = ListNode(1)
        head1.next = ListNode(2)
        head1.next?.next = ListNode(3)
        head1.next?.next?.next = ListNode(4)
        head1.next?.next?.next?.next = ListNode(5)

        var result = solution.reverseList(head1)
        var values = [Int]()
        while result != nil {
            values.append(result!.val)
            result = result?.next
        }
        #expect(values == [5,4,3,2,1])
    }

    @Test func example2() {
        let head2 = ListNode(1)
        head2.next = ListNode(2)

        var result = solution.reverseList(head2)
        var values = [Int]()
        while result != nil {
            values.append(result!.val)
            result = result?.next
        }
        #expect(values == [2,1])
    }

    @Test func example3() {
        let head3: ListNode? = nil
        var result = solution.reverseList(head3)
        var values: [Int] = []
        while result != nil {
            values.append(result!.val)
            result = result?.next
        }
        #expect(result == nil)
    }

}
