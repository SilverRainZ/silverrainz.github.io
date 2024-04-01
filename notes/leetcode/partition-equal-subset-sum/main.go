package main

import (
	"fmt"
	"math"
)

func canPartition(nums []int) bool {
	var sum int
	for _, num := range nums {
		sum += num
	}
	if sum%2 == 1 {
		return false // 奇数必不能被均分
	}
	sum /= 2 // 背包容量
	// fmt.Printf("sum: %d\n", sum)

	// 初始化状态数组，不使用滚动数组优化，因为想换一种写法
	var dp [][]int
	for i := 0; i <= len(nums); i++ {
		dp = append(dp, make([]int, sum+1))
	}

	// 要求恰好装满：
	// - 容量为 0 的情况下什么都不放，即 dp[i][0] = 0
	// - 没有东西可放时，容量非 0 的情况无解，即 dp[i][j] = -Inf where j != 0
	dp[0][0] = 0
	for j := 1; j <= sum; j++ {
		dp[0][j] = -math.MaxInt
	}

	for i := 1; i <= len(nums); i++ {
		for j := 0; j <= sum; j++ {
			if j-nums[i-1] >= 0 {
				dp[i][j] = max(dp[i-1][j], dp[i-1][j-nums[i-1]]+1)
				// fmt.Printf("dp[%d][%d] = max([%d][%d], [%d][%d]+1)\n", i, j, i-1, j, i-1, j-nums[i-1])
				// fmt.Printf("%d = max(%d, %d)\n", dp[i][j], dp[i-1][j], dp[i-1][j-nums[i-1]]+1)
			} else {
				dp[i][j] = dp[i-1][j] // 放不下，只能不放
			}
		}
		// fmt.Printf("i=%d: %v\n", i, dp[i])
	}

	return dp[len(nums)][sum] > 0
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func main() {
	// fmt.Println(canPartition([]int{2, 2}))
	// fmt.Println(canPartition([]int{1, 2, 9}))
	// fmt.Println(canPartition([]int{1, 5, 11, 5}))
	// fmt.Println(canPartition([]int{2, 2, 3, 5}))
	// fmt.Println(canPartition([]int{1, 5, 11, 5}))
	// fmt.Println(canPartition([]int{100}))
	fmt.Println(canPartition([]int{1, 5, 10, 6}))
}
