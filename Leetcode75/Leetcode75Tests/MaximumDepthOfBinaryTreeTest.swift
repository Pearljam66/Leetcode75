//
//  MaximumDepthOfBinaryTreeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/8/24.
//

/*
 Given the root of a binary tree, return its maximum depth.
 A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: 3

 Example 2:
 Input: root = [1,null,2]
 Output: 2

 Constraints:
 The number of nodes in the tree is in the range [0, 104].
 -100 <= Node.val <= 100
 */

import Testing

struct MaximumDepthOfBinaryTreeTest {


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
        func maxDepth(_ root: TreeNode?) -> Int {
            // Base case: if the current node is nil, the depth is 0
            guard let node = root else {
                return 0
            }

            // Recursively find the depth of the left and right subtrees
            let leftDepth = maxDepth(node.left)
            let rightDepth = maxDepth(node.right)

            // The depth of the current node is the maximum of the depths of its subtrees plus one
            return max(leftDepth, rightDepth) + 1
        }
    }

    @Test("Construct the tree: [3,9,20,null,null,15,7]") func example1() {
        let node15 = TreeNode(15)
        let node7 = TreeNode(7)
        let node20 = TreeNode(20, node15, node7)
        let node9 = TreeNode(9)
        let root = TreeNode(3, node9, node20)

        let solution = Solution()
        let result = solution.maxDepth(root)

        #expect(result == 3)
    }

    @Test("Construct the tree: [1,null,2]") func example2() {
        let node2 = TreeNode(2)
        let root = TreeNode(1, nil, node2)

        let solution = Solution()
        let result = solution.maxDepth(root)

        #expect(result == 2)
    }

}
