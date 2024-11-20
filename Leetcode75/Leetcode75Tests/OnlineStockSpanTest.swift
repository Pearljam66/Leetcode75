//
//  OnlineStockSpanTest.swift
//  Leetcode75Tests
//
//  Created by Sarah Clark on 11/20/24.
//

/*
 Design an algorithm that collects daily price quotes for some stock and returns the span of that stock's price for the current day.
 The span of the stock's price in one day is the maximum number of consecutive days (starting from that day and going backward) for which the stock price was less than or equal to the price of that day.
 For example, if the prices of the stock in the last four days is [7,2,1,2] and the price of the stock today is 2, then the span of today is 4 because starting from today, the price of the stock was less than or equal 2 for 4 consecutive days.
 Also, if the prices of the stock in the last four days is [7,34,1,2] and the price of the stock today is 8, then the span of today is 3 because starting from today, the price of the stock was less than or equal 8 for 3 consecutive days.
 Implement the StockSpanner class:
 StockSpanner() Initializes the object of the class.
 int next(int price) Returns the span of the stock's price given that today's price is price.

 Example 1:
 Input
 ["StockSpanner", "next", "next", "next", "next", "next", "next", "next"]
 [[], [100], [80], [60], [70], [60], [75], [85]]
 Output
 [null, 1, 1, 1, 2, 1, 4, 6]

 Explanation
 StockSpanner stockSpanner = new StockSpanner();
 stockSpanner.next(100); // return 1
 stockSpanner.next(80);  // return 1
 stockSpanner.next(60);  // return 1
 stockSpanner.next(70);  // return 2
 stockSpanner.next(60);  // return 1
 stockSpanner.next(75);  // return 4, because the last 4 prices (including today's price of 75) were less than or equal to today's price.
 stockSpanner.next(85);  // return 6

 Constraints:
 1 <= price <= 105
 At most 104 calls will be made to next.
 */

import Testing

struct OnlineStockSpanTest {

    class StockSpanner {

        // Stack to keep track of prices and their spans
        private var prices: [(price: Int, span: Int)]

        /**
         * Initializes the StockSpanner object.
         */
        init() {
            prices = []
        }

        /**
         * Calculates and returns the span for the given price.
         * - Parameter price: Today's stock price.
         * - Returns: The span of the stock's price.
         */
        func next(_ price: Int) -> Int {
            var span = 1

            // While there are previous prices and the current price is greater than or equal to the last price
            while !prices.isEmpty && price >= prices.last!.price {
                // Add the span of the last price to the current span
                span += prices.removeLast().span
            }

            // Add the current price with its span to the stack
            prices.append((price, span))

            return span
        }
    }

    /**
     * Your StockSpanner object will be instantiated and called as such:
     * let obj = StockSpanner()
     * let ret_1: Int = obj.next(price)
     */

    @Test func example1() {
        let stockSpanner = StockSpanner()

        // Testing each next() call with expected results
        #expect(stockSpanner.next(100) == 1)
        #expect(stockSpanner.next(80) == 1)
        #expect(stockSpanner.next(60) == 1)
        #expect(stockSpanner.next(70) == 2)
        #expect(stockSpanner.next(60) == 1)
        #expect(stockSpanner.next(75) == 4)
        #expect(stockSpanner.next(85) == 6)
    }

}
