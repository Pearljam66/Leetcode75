//
//  BinaryTreeRightSideViewTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/18/24.
//

/*
 Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

 Example 1:
 Input: root = [1,2,3,null,5,null,4]
 Output: [1,3,4]

 Example 2:
 Input: root = [1,null,3]
 Output: [1,3]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [0, 100].
 -100 <= Node.val <= 100
 */

import Testing

struct BinaryTreeRightSideViewTest {


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

        // Returns the right side view of a binary tree.
        func rightSideView(_ root: TreeNode?) -> [Int] {
            guard let root = root else { return [] }

            var result: [Int] = []
            var queue: [TreeNode] = [root]

            while !queue.isEmpty {
                // Store the current level's node count.
                let levelCount = queue.count

                // Process each node in the current level.
                for i in 0..<levelCount {
                    let node = queue.removeFirst()

                    // Add left child to queue if it exists.
                    if let leftChild = node.left {
                        queue.append(leftChild)
                    }

                    // Add right child to queue if it exists
                    if let rightChild = node.right {
                        queue.append(rightChild)
                    }

                    // If this is the last node of this level, add it's value to the result.
                    if i == levelCount - 1 {
                        result.append(node.val)
                    }
                }
            }
            // Returns an array of integers representing the values of nodes visible from the right side.
            return result
        }

    }

    @Test("Input: root = [1,2,3,null,5,null,4], Output: [1,3,4]") func example1() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.right = TreeNode(5)
        root.right?.right = TreeNode(4)
        let result = solution.rightSideView(root)

        #expect(result == [1, 3, 4])
    }

    @Test("Input: root = [1,null,3], Output: [1,3]") func example2() {
        let solution = Solution()
        let root = TreeNode(1)
        root.right = TreeNode(3)
        let result = solution.rightSideView(root)

        #expect(result == [1, 3])
    }

    @Test("Input: root = [], Output: []") func example3() {
        let solution = Solution()
        let root: TreeNode? = nil
        let result = solution.rightSideView(root)

        #expect(result == [])
    }

}
