package main

var memo []int

func climbStairs_inner(n int) int {
	if n < 0 {
		return 0
	}
	if memo[n] != -1 {
		return memo[n]
	}
	res := climbStairs_inner(n-1) + climbStairs_inner(n-2)
	memo[n] = res
	return res
}

// 暴搜 + 记忆
func climbStairs(n int) int {
	memo = make([]int, n+1)
	for i := range memo {
		memo[i] = -1
	}
	if n > 0 {
		memo[0] = 1
	}
	if n > 1 {
		memo[1] = 1
	}
	if n > 2 {
		memo[2] = 2
	}
	return climbStairs_inner(n)
}

// 递推解法
func climbStairs2(n int) int {
	res := make([]int, n+1)
	if n >= 1 {
		res[1] = 1
	}
	if n >= 2 {
		res[2] = 2
	}
	if n < 3 {
		return res[n]
	}
	for i := 3; i <= n; i++ {
		res[i] = res[i-1] + res[i-2]
	}
	return res[n]
}

func main() {
	println(climbStairs(1))
	println(climbStairs(2))
	println(climbStairs(3))
	println(climbStairs(6))
	println(climbStairs(45))

	println("--------------")

	println(climbStairs2(1))
	println(climbStairs2(2))
	println(climbStairs2(3))
	println(climbStairs2(6))
	println(climbStairs2(45))
}
