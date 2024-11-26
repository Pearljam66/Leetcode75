//
//  BestTimeToBuyAndSellStockWithTransactionFeeTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/26/24.
//

/*
 You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.
 Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.
 Note:
 You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
 The transaction fee is only charged once for each stock purchase and sale.

 Example 1:
 Input: prices = [1,3,2,8,4,9], fee = 2
 Output: 8
 Explanation: The maximum profit can be achieved by:
 - Buying at prices[0] = 1
 - Selling at prices[3] = 8
 - Buying at prices[4] = 4
 - Selling at prices[5] = 9
 The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.

 Example 2:
 Input: prices = [1,3,7,5,10,3], fee = 3
 Output: 6

 Constraints:
 1 <= prices.length <= 5 * 104
 1 <= prices[i] < 5 * 104
 0 <= fee < 5 * 104
 */

import Testing

struct BestTimeToBuyAndSellStockWithTransactionFeeTest {

    class Solution {
        func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
            // If there are fewer than 2 prices, no profit can be made
            guard prices.count > 1 else { return 0 }

            // Initialize variables to keep track of cash in hand and the value of the stock if bought
            var cash = 0
            var hold = -prices[0] // Negative because we spend money to buy stock

            for i in 1..<prices.count {
                // Save the previous cash value to avoid overwriting it
                let prevCash = cash

                // Decide whether to keep holding the current stock or sell it
                cash = max(cash, hold + prices[i] - fee)

                // Decide whether to buy the current stock or keep the cash
                hold = max(hold, prevCash - prices[i])
            }

            // At the end, we'll have cash which is our maximum profit
            return cash
        }
    }

    @Test func example1() {
        #expect(Solution().maxProfit([1, 3, 2, 8, 4, 9], 2) == 8)
    }

    @Test func example2() {
        #expect(Solution().maxProfit([1, 3, 7, 5, 10, 3], 3) == 6)
    }

}
