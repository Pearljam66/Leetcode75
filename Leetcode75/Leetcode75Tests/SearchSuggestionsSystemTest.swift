//
//  SearchSuggestionsSystemTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/28/24.
//

/*
 You are given an array of strings products and a string searchWord.
 Design a system that suggests at most three product names from products after each character of searchWord is typed.
 Suggested products should have common prefix with searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.
 Return a list of lists of the suggested products after each character of searchWord is typed.

 Example 1:
 Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
 Output: [["mobile","moneypot","monitor"],["mobile","moneypot","monitor"],["mouse","mousepad"],["mouse","mousepad"],["mouse","mousepad"]]
 Explanation: products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"].
 After typing m and mo all products match and we show user ["mobile","moneypot","monitor"].
 After typing mou, mous and mouse the system suggests ["mouse","mousepad"].

 Example 2:
 Input: products = ["havana"], searchWord = "havana"
 Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]
 Explanation: The only word "havana" will be always suggested while typing the search word.

 Constraints:
 1 <= products.length <= 1000
 1 <= products[i].length <= 3000
 1 <= sum(products[i].length) <= 2 * 104
 All the strings of products are unique.
 products[i] consists of lowercase English letters.
 1 <= searchWord.length <= 1000
 searchWord consists of lowercase English letters.
 */

import Testing

struct SearchSuggestionsSystemTest {

    class Solution {
        class TrieNode {
            var children: [Character: TrieNode] = [:]
            var productIndices: [Int] = []
        }

        func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
            // Sort products lexicographically
            let sortedProducts = products.sorted()

            // Build the trie
            let root = TrieNode()
            for (index, product) in sortedProducts.enumerated() {
                var current = root
                for char in product {
                    if current.children[char] == nil {
                        current.children[char] = TrieNode()
                    }
                    current = current.children[char]!
                    if current.productIndices.count < 3 {
                        current.productIndices.append(index)
                    }
                }
            }

            // Search through the trie as we type each character
            var result = [[String]]()
            var current = root

            for char in searchWord {
                guard let next = current.children[char] else {
                    // If there's no path for this character, we'll add empty arrays for the remaining characters
                    result.append(contentsOf: [[String]](repeating: [], count: searchWord.count - result.count))
                    break
                }
                current = next
                // Gather the suggested products for this prefix
                let suggestions = current.productIndices.map { sortedProducts[$0] }
                result.append(suggestions)
            }

            // If we've finished typing searchWord but didn't fill result to match its length
            while result.count < searchWord.count {
                result.append([])
            }

            return result
        }
    }

    @Test func example1() {
        #expect(Solution().suggestedProducts(["mobile", "mouse", "moneypot", "monitor", "mousepad"], "mouse") == [["mobile", "moneypot", "monitor"], ["mobile", "moneypot", "monitor"], ["mouse", "mousepad"], ["mouse", "mousepad"], ["mouse", "mousepad"]])
    }

    @Test func example2() {
        #expect(Solution().suggestedProducts(["havana"], "havana") == [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]])
    }

}
