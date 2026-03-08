package main

import "fmt"

func count01(s string) (int, int) {
	count0 := 0
	count1 := 0
	for _, c := range s {
		if c == '0' {
			count0++
		} else {
			count1++
		}
	}
	return count0, count1
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func findMaxForm(strs []string, m int, n int) int {
	var dp [][]int
	for i := 0; i <= m; i++ {
		dp = append(dp, make([]int, n+1))
	}
	c0, c1 := count01(strs[0])
	for i := c0; i <= m; i++ {
		for j := c1; j <= n; j++ {
			dp[i][j] = 1
		}
	}
	for z, s := range strs {
		if z == 0 {
			continue
		}
		c0, c1 := count01(s)
		for i := m; i >= c0; i-- {
			for j := n; j >= c1; j-- {
				dp[i][j] = max(dp[i][j], dp[i-c0][j-c1]+1)
			}
		}
	}
	return dp[m][n]
}

func main() {
	fmt.Println(findMaxForm([]string{"10", "0001", "111001", "1", "0"}, 5, 3))
	fmt.Println(findMaxForm([]string{"10", "0", "1"}, 1, 1))
}
