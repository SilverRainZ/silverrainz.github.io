package main

import "fmt"

func removeDuplicates(nums []int) int {
	ptr := 0
	for i := 1; i < len(nums); i++ {
		if nums[i] == nums[ptr] {
			continue
		} else {
			ptr++
			nums[ptr] = nums[i]
		}
	}
	return ptr+1
}

func main() {
	nums := []int{0,0,1,1,1,2,2,3,3,4}
	fmt.Println(removeDuplicates(nums))
}
