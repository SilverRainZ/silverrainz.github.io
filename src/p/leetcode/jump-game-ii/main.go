package main

import (
	"fmt"
)

// https://medium.com/@william31525/leetcode-45-jump-game-2-294a21f5baba
func jump(nums []int) int {
	if len(nums) <= 2 {
		return len(nums) - 1
	}

	var footprints []int
	for {
		lastStep := -1
		for i := 0; i < len(nums); i++ {
			if i + nums[i] >= len(nums) - 1 {
				lastStep = i
				footprints = append(footprints, lastStep)
				break
			}
		}
		if lastStep == 0 {
			break
		}
		nums = nums[:lastStep+1]
	}
	return len(footprints)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func jump2(nums []int) int {
	if len(nums) <= 2 {
		return len(nums) - 1
	}

	farest := 0
	end := 0
	step := 0

	for i := 0; i < len(nums); i++ {
		farest = max(farest, i+nums[i])
		if i == end {
			end = farest
			step++
		}
		if end >= len(nums) - 1 {
			break
		}
	}
	return step
}


func main() {
	fmt.Println(jump([]int{2,3,1,1,4}))
	fmt.Println(jump([]int{1,1,1,1,1}))
	fmt.Println(jump([]int{3,1,0}))
	fmt.Println(jump([]int{2,3,1}))
	fmt.Println(jump([]int{2,3,1,4}))
	fmt.Println(jump([]int{2,3,1,1,4}))

	fmt.Println("===")

	fmt.Println(jump2([]int{2,3,1,1,4}))
	fmt.Println(jump2([]int{1,1,1,1,1}))
	fmt.Println(jump2([]int{3,1,0}))
	fmt.Println(jump2([]int{2,3,1}))
	fmt.Println(jump2([]int{2,3,1,4}))
	fmt.Println(jump2([]int{2,3,1,1,4}))
}
