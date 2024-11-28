//
//  SearchInBinarySearchTreeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/28/24.
//

/*
 You are given the root of a binary search tree (BST) and an integer val
 Find the node in the BST that the node's value equals val and return the subtree rooted with that node. If such a node does not exist, return null.

 Example 1:
 Input: root = [4,2,7,1,3], val = 2
 Output: [2,1,3]

 Example 2:
 Input: root = [4,2,7,1,3], val = 5
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [1, 5000].
 1 <= Node.val <= 107
 root is a binary search tree.
 1 <= val <= 107
 */

import Testing

struct SearchInBinarySearchTreeTest {
    let solution = Solution()
    let root = TreeNode(4)

    init () async throws {
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)
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
        func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
            // Base case: if root is nil or if we've found the node with the value.
            if root == nil || root?.val == val {
                return root
            }

            // If the value is less than the root's value, search in the left subtree.
            if val < root!.val {
                return searchBST(root?.left, val)
            } else {
                // If the value is greater than the root's value, search in the right subtree.
                return searchBST(root?.right, val)
            }
        }
    }

    @Test("Input: root = [4,2,7,1,3], val = 2, Output: [2,1,3]") func example1() {
        let result = solution.searchBST(root, 2)
        #expect(result?.val == 2)
        #expect(result?.left?.val == 1)
        #expect(result?.right?.val == 3)
    }

    @Test("Input: root = [4,2,7,1,3], val = 5, Output: []") func example2() {
        let result = solution.searchBST(root, 5)
        #expect(result == nil)
    }

}
