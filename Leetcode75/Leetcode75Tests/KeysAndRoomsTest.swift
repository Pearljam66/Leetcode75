//
//  KeysAndRoomsTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/29/24.
//

/*
 There are n rooms labeled from 0 to n - 1 and all the rooms are locked except for room 0. Your goal is to visit all the rooms. However, you cannot enter a locked room without having its key.
 When you visit a room, you may find a set of distinct keys in it. Each key has a number on it, denoting which room it unlocks, and you can take all of them with you to unlock the other rooms.
 Given an array rooms where rooms[i] is the set of keys that you can obtain if you visited room i, return true if you can visit all the rooms, or false otherwise.

 Example 1:
 Input: rooms = [[1],[2],[3],[]]
 Output: true
 Explanation:
 We visit room 0 and pick up key 1.
 We then visit room 1 and pick up key 2.
 We then visit room 2 and pick up key 3.
 We then visit room 3.
 Since we were able to visit every room, we return true.

 Example 2:
 Input: rooms = [[1,3],[3,0,1],[2],[0]]
 Output: false
 Explanation: We can not enter room number 2 since the only key that unlocks it is in that room.

 Constraints:
 n == rooms.length
 2 <= n <= 1000
 0 <= rooms[i].length <= 1000
 1 <= sum(rooms[i].length) <= 3000
 0 <= rooms[i][j] < n
 All the values of rooms[i] are unique.
 */

import Testing

struct KeysAndRoomsTest {

    class Solution {
        func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
            // Set to track which rooms we've visited
            var visited = Set<Int>()

            // Start with room 0
            visitRoom(0, rooms: rooms, visited: &visited)

            // Check if we've visited all rooms
            return visited.count == rooms.count
        }

        private func visitRoom(_ room: Int, rooms: [[Int]], visited: inout Set<Int>) {
            // If we've already visited this room, return
            if visited.contains(room) {
                return
            }

            // Mark this room as visited
            visited.insert(room)

            // Visit all rooms that this room's key can unlock
            for key in rooms[room] {
                visitRoom(key, rooms: rooms, visited: &visited)
            }
        }
    }

    @Test func example1() {
        #expect(Solution().canVisitAllRooms([[1], [2], [3], []]))
    }

    @Test func example2() {
        #expect(!Solution().canVisitAllRooms([[1, 3], [3, 0, 1], [2], [0]]))
    }

}
