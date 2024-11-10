//
//  LeafSimilarTreesTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/10/24.
//

/*
 Consider all the leaves of a binary tree, from left to right order, the values of those leaves form a leaf value sequence.
 For example, in the given tree above, the leaf value sequence is (6, 7, 4, 9, 8).
 Two binary trees are considered leaf-similar if their leaf value sequence is the same.
 Return true if and only if the two given trees with head nodes root1 and root2 are leaf-similar.

 Example 1:
 Input: root1 = [3,5,1,6,2,9,8,null,null,7,4], root2 = [3,5,1,6,7,4,2,null,null,null,null,null,null,9,8]
 Output: true

 Example 2:
 Input: root1 = [1,2,3], root2 = [1,3,2]
 Output: false

 Constraints:
 The number of nodes in each tree will be in the range [1, 200].
 Both of the given trees will have values in the range [0, 200].
 */

import Testing

struct LeafSimilarTreesTest {

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
        func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
            return dfs(root1) == dfs(root2)
        }

        private func dfs(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            if node.left == nil, node.right == nil {
                return [node.val]
            }
            return dfs(node.left) + dfs(node.right)
        }
    }

    @Test func example1() {
        let root1 = TreeNode(3,
                             TreeNode(5, TreeNode(6), TreeNode(2, TreeNode(7), TreeNode(4))),
                             TreeNode(1, TreeNode(9), TreeNode(8)))
        let root2 = TreeNode(3,
                             TreeNode(5, TreeNode(6), TreeNode(7)),
                             TreeNode(1, TreeNode(4), TreeNode(2, TreeNode(9), TreeNode(8))))
        #expect(Solution().leafSimilar(root1, root2) == true)
    }

    @Test func example2() {
        let root1 = TreeNode(1, TreeNode(2), TreeNode(3))
        let root2 = TreeNode(1, TreeNode(3), TreeNode(2))
        #expect(Solution().leafSimilar(root1, root2) == false)
    }

}
