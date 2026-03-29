package main

import "fmt"

func canJump(nums []int) bool {
	if len(nums) <= 1 {
		return true
	}
	max := 0;
	for i := 0; i < len(nums); i++ {
		if max < i {
			break
		}
		if max < i+nums[i] {
			max = i+nums[i] 
		}
	}
	return max >= len(nums) - 1
}

func main() {
	fmt.Println(canJump([]int{3,2,1,0,4}))
}
