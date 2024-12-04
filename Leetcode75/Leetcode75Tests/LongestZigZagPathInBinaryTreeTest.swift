//
//  LongestZigZagPathInBinaryTreeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/13/24.
//

/*
 You are given the root of a binary tree.
 A ZigZag path for a binary tree is defined as follow:
 Choose any node in the binary tree and a direction (right or left).
 If the current direction is right, move to the right child of the current node; otherwise, move to the left child.
 Change the direction from right to left or from left to right.
 Repeat the second and third steps until you can't move in the tree.
 Zigzag length is defined as the number of nodes visited - 1. (A single node has a length of 0).

 Return the longest ZigZag path contained in that tree.

 Example 1:
 Input: root = [1,null,1,1,1,null,null,1,1,null,1,null,null,null,1]
 Output: 3
 Explanation: Longest ZigZag path in blue nodes (right -> left -> right).

 Example 2:
 Input: root = [1,1,1,null,1,null,null,1,1,null,1]
 Output: 4
 Explanation: Longest ZigZag path in blue nodes (left -> right -> left -> right).

 Example 3:
 Input: root = [1]
 Output: 0

 Constraints:
 The number of nodes in the tree is in the range [1, 5 * 104].
 1 <= Node.val <= 100
 */


import Testing

struct LongestZigZagPathInBinaryTreeTest {

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
        private var maxLength = 0

        func longestZigZag(_ root: TreeNode?) -> Int {
            dfs(root, true, 0) // Start with left (true) and no steps (0)
            dfs(root, false, 0) // Start with right (false) and no steps (0)
            return maxLength
        }

        private func dfs(_ node: TreeNode?, _ goLeft: Bool, _ steps: Int) {
            guard let node = node else {
                maxLength = max(maxLength, steps - 1) // -1 because we count the parent node
                return
            }

            if goLeft {
                dfs(node.left, false, steps + 1)
                dfs(node.right, true, 1)
            } else {
                dfs(node.right, true, steps + 1)
                dfs(node.left, false, 1)
            }
        }
    }

    @Test func example1() {
        let solution = Solution()
        let root1 = TreeNode(1)
        root1.right = TreeNode(1)
        root1.right?.left = TreeNode(1)
        root1.right?.right = TreeNode(1)
        root1.right?.left?.right = TreeNode(1)
        root1.right?.right?.left = TreeNode(1)
        root1.right?.right?.left?.right = TreeNode(1)
        #expect(solution.longestZigZag(root1) == 3)
    }

    @Test func example2() {
        let solution = Solution()
        let root2 = TreeNode(1)
        root2.left = TreeNode(1)
        root2.right = TreeNode(1)
        root2.left?.right = TreeNode(1)
        root2.left?.right?.left = TreeNode(1)
        root2.left?.right?.left?.right = TreeNode(1)
        #expect(solution.longestZigZag(root2) == 4)
    }

    @Test func example3() {
        let solution = Solution()
        let root3 = TreeNode(1)
        #expect(solution.longestZigZag(root3) == 0)
    }

}
