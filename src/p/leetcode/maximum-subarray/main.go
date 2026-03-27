package main

// import "fmt"
import "math"

func maxSubArray_Foolish(nums []int) int {
	max := -math.MaxInt64
	for i := 0; i < len(nums); i ++ {
		sum := 0
		for j := i; j < len(nums); j++ {
			sum += nums[j]
			if sum > max {
				max = sum
			}
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
	println(maxSubArray([]int{-2, -3, -1}))
	println(maxSubArray([]int{8, -19, 5, -4, 20}))
}
