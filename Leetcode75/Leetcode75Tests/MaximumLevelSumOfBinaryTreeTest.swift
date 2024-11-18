//
//  MaximumLevelSumOfBinaryTreeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/18/24.
//

/*
 Given the root of a binary tree, the level of its root is 1, the level of its children is 2, and so on.
 Return the smallest level x such that the sum of all the values of nodes at level x is maximal.

 Example 1:
 Input: root = [1,7,0,7,-8,null,null]
 Output: 2
 Explanation:
 Level 1 sum = 1.
 Level 2 sum = 7 + 0 = 7.
 Level 3 sum = 7 + -8 = -1.
 So we return the level with the maximum sum which is level 2.

 Example 2:
 Input: root = [989,null,10250,98693,-89388,null,null,null,-32127]
 Output: 2

 Constraints:
 The number of nodes in the tree is in the range [1, 104].
 -105 <= Node.val <= 105
 */

import Testing

struct MaximumLevelSumOfBinaryTreeTest {

    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?

        init() {
            self.val = 0
            self.left = nil
            self.right = nil
        }

        init (_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }

        init(_ val: Int, _ left: TreeNode?, _ right: TreeNode) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution {

        // Returns the level in the binary tree where the sum of the node values is the greatest.
        func maxLevelSum(_ root: TreeNode?) -> Int {
            guard let root else { return 0 }

            var queue: [TreeNode] = [root]
            var level = 1
            // Stores the maximum sum encountered so far.
            var maxSum = Int.min
            // Keeps track of the level which had this maximum sum.
            var maxLevel = 1

            while !queue.isEmpty {
                let levelCount = queue.count
                var levelSum = 0

                for _ in 0..<levelCount {
                    let node = queue.removeFirst()
                    levelSum += node.val

                    if let left = node.left {
                        queue.append(left)
                    }

                    if let right = node.right {
                        queue.append(right)
                    }
                }

                // If the current level sum is greater than the max sum, update it.
                if levelSum > maxSum {
                    maxSum = levelSum
                    maxLevel = level
                }
                level += 1
            }
            return maxLevel
        }

    }

    @Test("Input: root = [1,7,0,7,-8,null,null], Output: 2") func example1() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(7)
        root.right = TreeNode(0)
        root.left?.left = TreeNode(7)
        root.left?.right = TreeNode(-8)

        let result = solution.maxLevelSum(root)
        #expect(result == 2)
    }

    @Test("Input: root = [989,null,10250,98693,-89388,null,null,null,-32127], Output: 2") func example2() {
        let solution = Solution()
        let root = TreeNode(989)
        root.right = TreeNode(10250)
        root.left?.left = TreeNode(98693)
        root.left?.right = TreeNode(-89388)
        root.left?.right?.left = TreeNode(-32127)

        let result = solution.maxLevelSum(root)
        #expect(result == 2)
    }

    @Test("Input: root = [1,1,0,7,-8,-7,9], Output: 1") func example3() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(1)
        root.right = TreeNode(0)
        root.left?.left = TreeNode(7)
        root.left?.right = TreeNode(-8)
        root.right?.left = TreeNode(-7)
        root.right?.right = TreeNode(9)

        let result = solution.maxLevelSum(root)
        #expect(result == 1)
    }

}
