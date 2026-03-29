package main

import "fmt"

func maxProfit(prices []int) int {
	if len(prices) <= 1 {
		return 0
	}
	profit := 0
	low := prices[0]

	for i := 0; i < len(prices); i++ {
		if prices[i] > low {
			profit += prices[i] - low
		}
		low = prices[i]
	}
	return profit
}

func main() {
	fmt.Println(maxProfit([]int{7,1,5,3,6,4}))
}
