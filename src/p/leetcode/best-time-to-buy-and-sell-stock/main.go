package main

import "fmt"

func maxProfit(prices []int) int {
	if len(prices) <= 1 {
		return 0
	}
	maxProfit := 0
	lowPrice := prices[0]
	for i := 1; i < len(prices); i++ {
		if prices[i] - lowPrice > maxProfit {
			maxProfit = prices[i] - lowPrice
		}
		if lowPrice > prices[i] {
			lowPrice = prices[i]
		}
	}
	return maxProfit
}

func main() {
	fmt.Println(maxProfit([]int{0}))
	fmt.Println(maxProfit([]int{1}))
	fmt.Println(maxProfit([]int{7,1,5,3,6,4}))
	fmt.Println(maxProfit([]int{7,6,4,3,1}
}
