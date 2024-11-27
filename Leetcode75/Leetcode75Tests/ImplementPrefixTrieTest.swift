//
//  ImplementPrefixTrieTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/27/24.
//

/*
 A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings.
 There are various applications of this data structure, such as autocomplete and spellchecker.

 Implement the Trie class:
 Trie() Initializes the trie object.
 void insert(String word) Inserts the string word into the trie.
 boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
 boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.

 Example 1:
 Input
 ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
 [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
 Output
 [null, null, true, false, true, null, true]

 Explanation
 Trie trie = new Trie();
 trie.insert("apple");
 trie.search("apple");   // return True
 trie.search("app");     // return False
 trie.startsWith("app"); // return True
 trie.insert("app");
 trie.search("app");     // return True

 Constraints:
 1 <= word.length, prefix.length <= 2000
 word and prefix consist only of lowercase English letters.
 At most 3 * 104 calls in total will be made to insert, search, and startsWith.
 */

import Testing

struct ImplementPrefixTrieTest {

    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isEndOfWord: Bool = false

        init() {}
    }

    class Trie {
        private let root: TrieNode

        init() {
            root = TrieNode()
        }

        func insert(_ word: String) {
            var node = root
            for char in word {
                if node.children[char] == nil {
                    node.children[char] = TrieNode()
                }
                node = node.children[char]!
            }
            node.isEndOfWord = true
        }

        func search(_ word: String) -> Bool {
            if let node = findNode(word) {
                return node.isEndOfWord
            }
            return false
        }

        func startsWith(_ prefix: String) -> Bool {
            return findNode(prefix) != nil
        }

        private func findNode(_ word: String) -> TrieNode? {
            var node = root
            for char in word {
                guard let child = node.children[char] else {
                    return nil
                }
                node = child
            }
            return node
        }
    }

    @Test func example1() {
        let trie = Trie()
        trie.insert("apple")
        #expect(trie.search("apple"))
        #expect(!trie.search("app"))
        #expect(trie.startsWith("app"))
        trie.insert("app")
        #expect(trie.search("app"))
    }

}
