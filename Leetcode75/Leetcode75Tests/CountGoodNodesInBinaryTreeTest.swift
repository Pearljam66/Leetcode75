//
//  CountGoodNodesInBinaryTreeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/11/24.
//

/*
 Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.
 Return the number of good nodes in the binary tree.

 Example 1:
 Input: root = [3,1,4,3,null,1,5]
 Output: 4
 Explanation: Nodes in blue are good.
 Root Node (3) is always a good node.
 Node 4 -> (3,4) is the maximum value in the path starting from the root.
 Node 5 -> (3,4,5) is the maximum value in the path
 Node 3 -> (3,1,3) is the maximum value in the path.

 Example 2:
 Input: root = [3,3,null,4,2]
 Output: 3
 Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.

 Example 3:
 Input: root = [1]
 Output: 1
 Explanation: Root is considered as good.

 Constraints:
 The number of nodes in the binary tree is in the range [1, 10^5].
 Each node's value is between [-10^4, 10^4].
 */

import Testing

struct CountGoodNodesInBinaryTreeTest {

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
        func goodNodes(_ root: TreeNode?) -> Int {
            return countGoodNodes(root, maxSoFar: root?.val ?? Int.min)
        }

        private func countGoodNodes(_ node: TreeNode?, maxSoFar: Int) -> Int {
            guard let node = node else { return 0 }

            // Check if the current node is a good node
            let isGood = node.val >= maxSoFar ? 1 : 0

            // Update the max value for the path to children nodes
            let newMax = max(maxSoFar, node.val)

            // Count good nodes in the left and right subtrees
            let leftGoodNodes = countGoodNodes(node.left, maxSoFar: newMax)
            let rightGoodNodes = countGoodNodes(node.right, maxSoFar: newMax)

            // Total count of good nodes for this subtree
            return isGood + leftGoodNodes + rightGoodNodes
        }
    }

    func createTree(_ values: [Int?]) -> CountGoodNodesInBinaryTreeTest.TreeNode? {
        guard !values.isEmpty, let first = values[0] else { return nil }

        let root = CountGoodNodesInBinaryTreeTest.TreeNode(first)
        var queue = [root]
        var index = 1

        while index < values.count {
            let node = queue.removeFirst()

            if index < values.count, let leftValue = values[index] {
                node.left = CountGoodNodesInBinaryTreeTest.TreeNode(leftValue)
                queue.append(node.left!)
            }
            index += 1

            if index < values.count, let rightValue = values[index] {
                node.right = CountGoodNodesInBinaryTreeTest.TreeNode(rightValue)
                queue.append(node.right!)
            }
            index += 1
        }

        return root
    }

    @Test("Expected 4 good nodes for input [3, 1, 4, 3, nil, 1, 5]") func testExample1() {
        let root = createTree([3, 1, 4, 3, nil, 1, 5])
        let solution = CountGoodNodesInBinaryTreeTest.Solution()
        let result = solution.goodNodes(root)
        #expect(result == 4)
    }

    @Test("Expected 3 good nodes for input [3, 3, nil, 4, 2]")func testExample2() {
        let root = createTree([3, 3, nil, 4, 2])
        let solution = CountGoodNodesInBinaryTreeTest.Solution()
        let result = solution.goodNodes(root)
        #expect(result == 3)
    }

    @Test("Expected 1 good node for input [1]") func testExample3() {
        let root = createTree([1])
        let solution = CountGoodNodesInBinaryTreeTest.Solution()
        let result = solution.goodNodes(root)
        #expect(result == 1)
    }

}
