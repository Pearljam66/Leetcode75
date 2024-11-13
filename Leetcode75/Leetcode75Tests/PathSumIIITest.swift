//
//  PathSumIIITest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/13/24.
//

/*
 Given the root of a binary tree and an integer targetSum, return the number of paths where the sum of the values along the path equals targetSum.
 The path does not need to start or end at the root or a leaf, but it must go downwards (i.e., traveling only from parent nodes to child nodes).

 Example 1:
 Input: root = [10,5,-3,3,2,null,11,3,-2,null,1], targetSum = 8
 Output: 3
 Explanation: The paths that sum to 8 are shown.

 Example 2:
 Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
 Output: 3

 Constraints:
 The number of nodes in the tree is in the range [0, 1000].
 -109 <= Node.val <= 109
 -1000 <= targetSum <= 1000
 */

import Testing

struct PathSumIIITest {

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
        func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
            guard let root else { return 0 }
            return countPaths(root, targetSum) + pathSum(root.left, targetSum) + pathSum(root.right, targetSum)
        }

        private func countPaths(_ node: TreeNode?, _ targetSum: Int) -> Int {
            guard let node = node else { return 0 }

            var count = 0
            // Check if current node's value equals target
            if node.val == targetSum {
                count += 1
            }

            // Continue path to children with remaining sum
            count += countPaths(node.left, targetSum - node.val)
            count += countPaths(node.right, targetSum - node.val)

            return count
        }
    }

    let solution = Solution()

    @Test("Create tree: [10,5,-3,3,2,null,11,3,-2,null,1]") func example1() {
        let root = TreeNode(10)
        root.left = TreeNode(5)
        root.right = TreeNode(-3)

        root.left?.left = TreeNode(3)
        root.left?.right = TreeNode(2)
        root.right?.right = TreeNode(11)

        root.left?.left?.left = TreeNode(3)
        root.left?.left?.right = TreeNode(-2)
        root.left?.right?.right = TreeNode(1)

        let result = solution.pathSum(root, 8)
        #expect(result == 3)
    }

    @Test("Create tree: [5,4,8,11,null,13,4,7,2,null,null,5,1]") func example2() {
        let root = TreeNode(5)
        root.left = TreeNode(4)
        root.right = TreeNode(8)

        root.left?.left = TreeNode(11)
        root.right?.left = TreeNode(13)
        root.right?.right = TreeNode(4)

        root.left?.left?.left = TreeNode(7)
        root.left?.left?.right = TreeNode(2)
        root.right?.right?.left = TreeNode(5)
        root.right?.right?.right = TreeNode(1)

        let result = solution.pathSum(root, 22)
        #expect(result == 3)
    }

}
