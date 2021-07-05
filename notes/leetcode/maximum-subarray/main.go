package main

func maxSubArray(nums []int) int {
	max := nums[0]
	m := make([]int, len(nums))
	for i, v := range nums {
		if i == 0 || m[i-1] < 0 {
			m[i] = v
		} else if m[i-1]+v < 0 {
			m[i] = v
		} else {
			m[i] = m[i-1] + v
		}
		if m[i] > max {
			max = m[i]
		}
	}
	return max
}

func main() {
	println(maxSubArray([]int{-2, 1, -3, 4, -1, 2, 1, -5, 4}))
	println(maxSubArray([]int{-1, -1, -1, -1}))
	println(maxSubArray([]int{1}))
	println(maxSubArray([]int{1, 2, 3}))
	println(maxSubArray([]int{1, 2, 3, -1}))
	println(maxSubArray([]int{-1, 1, 2, 3, -1}))
}
