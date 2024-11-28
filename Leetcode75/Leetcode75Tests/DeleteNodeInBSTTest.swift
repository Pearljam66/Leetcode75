//
//  DeleteNodeInBSTTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/28/24.
//

/*
 Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.
 Basically, the deletion can be divided into two stages:
 Search for a node to remove.
 If the node is found, delete the node.

 Example 1:
 Input: root = [5,3,6,2,4,null,7], key = 3
 Output: [5,4,6,2,null,null,7]
 Explanation: Given key to delete is 3. So we find the node with value 3 and delete it.
 One valid answer is [5,4,6,2,null,null,7], shown in the above BST.
 Please notice that another valid answer is [5,2,6,null,4,null,7] and it's also accepted.

 Example 2:
 Input: root = [5,3,6,2,4,null,7], key = 0
 Output: [5,3,6,2,4,null,7]
 Explanation: The tree does not contain a node with value = 0.

 Example 3:
 Input: root = [], key = 0
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [0, 104].
 -105 <= Node.val <= 105
 Each node has a unique value.
 root is a valid binary search tree.
 -105 <= key <= 105
 */

import Testing

struct DeleteNodeInBSTTest {
    let solution = Solution()
    var root = TreeNode(5)

    init() async throws {
        root.left = TreeNode(3)
        root.right = TreeNode(6)
        root.left?.left = TreeNode(2)
        root.left?.right = TreeNode(4)
        root.right?.right = TreeNode(7)
    }

    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution {
        func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
            guard let root else { return nil }

            // If the key to be deleted is less than the root's value, then it lies in left subtree
            if key < root.val {
                root.left = deleteNode(root.left, key)
            }
            // If the key to be deleted is greater than the root's value, then it lies in right subtree
            else if key > root.val {
                root.right = deleteNode(root.right, key)
            }
            // If key is same as root's value, then this is the node to be deleted
            else {
                // Case 1: Node with only one child or no child
                if root.left == nil {
                    return root.right
                } else if root.right == nil {
                    return root.left
                }

                // Case 2: Node with two children: Get the inorder successor (smallest in the right subtree)
                root.val = minValue(root.right!)
                // Delete the inorder successor
                root.right = deleteNode(root.right, root.val)
            }
            return root
        }

        // Helper function to find the smallest value in the subtree
        private func minValue(_ node: TreeNode) -> Int {
            var current = node
            while current.left != nil {
                current = current.left!
            }
            return current.val
        }
    }

    @Test func example1() {
        let result = solution.deleteNode(root, 3)
        #expect(result?.val == 5)
        #expect(result?.left?.val == 4)
        #expect(result?.right?.val == 6)
        #expect(result?.left?.left?.val == 2)
        #expect(result?.left?.right?.val == nil)
        #expect(result?.right?.left?.val == nil)
        #expect(result?.right?.right?.val == 7)
    }

    @Test func example2() {
        let result = solution.deleteNode(root, 0)
        #expect(result?.val == 5)
        #expect(result?.left?.val == 3)
        #expect(result?.right?.val == 6)
        #expect(result?.left?.left?.val == 2)
        #expect(result?.left?.right?.val == 4)
        #expect(result?.right?.left?.val == nil)
        #expect(result?.right?.right?.val == 7)
    }

    @Test func example3() {
        let newRoot: TreeNode? = nil
        let result = solution.deleteNode(newRoot, 10)
        #expect(result == nil)
    }

}
