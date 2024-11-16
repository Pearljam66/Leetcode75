//
//  LowestCommonAncestorTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/16/24.
//

/*
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 Example 1:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 Output: 3
 Explanation: The LCA of nodes 5 and 1 is 3.

 Example 2:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 Output: 5
 Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

 Example 3:
 Input: root = [1,2], p = 1, q = 2
 Output: 1

 Constraints:
 The number of nodes in the tree is in the range [2, 105].
 -109 <= Node.val <= 109
 All Node.val are unique.
 p != q
 p and q will exist in the tree.
 */

import Testing

struct LowestCommonAncestorTest {

    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
        }
    }

    class Solution {
        func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
            // Base case: if root is null or if root is one of p or q, return root
            guard let root = root else { return nil }
            if root === p || root === q { return root }

            // Check if p and q are on the left or right subtree
            let leftResult  = lowestCommonAncestor(root.left, p, q)
            let rightResult = lowestCommonAncestor(root.right, p, q)

            // If both leftResult and rightResult are not nil, then root is LCA
            if leftResult != nil && rightResult != nil {
                return root
            }

            // If one of them is nil, return the non-nil one
            return leftResult ?? rightResult
        }
    }

    @Test("[3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1") func testExample1() {
        let solution = Solution()
        let root = TreeNode(3)
        root.left = TreeNode(5)
        root.right = TreeNode(1)
        root.left!.left = TreeNode(6)
        root.left!.right = TreeNode(2)
        root.right!.left = TreeNode(0)
        root.right!.right = TreeNode(8)
        root.left!.right!.left = TreeNode(7)
        root.left!.right!.right = TreeNode(4)

        let p = root.left!
        let q = root.right!

        let lca = solution.lowestCommonAncestor(root, p, q)
        #expect(lca?.val == 3)
    }

    @Test("[3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4") func testExample2() {
        let solution = Solution()
        let root = TreeNode(3)
        root.left = TreeNode(5)
        root.right = TreeNode(1)
        root.left!.left = TreeNode(6)
        root.left!.right = TreeNode(2)
        root.right!.left = TreeNode(0)
        root.right!.right = TreeNode(8)
        root.left!.right!.left = TreeNode(7)
        root.left!.right!.right = TreeNode(4)

        let p = root.left!
        let q = root.left!.right!.right! // node 4

        let lca = solution.lowestCommonAncestor(root, p, q)
        #expect(lca?.val == 5)
    }

    @Test("[1,2], p = 1, q = 2") func testExample3() {
        let solution = Solution()
        let root = TreeNode(1)
        root.right = TreeNode(2)

        let p = root
        let q = root.right!

        let lca = solution.lowestCommonAncestor(root, p, q)
        #expect(lca?.val == 1)
    }

}
