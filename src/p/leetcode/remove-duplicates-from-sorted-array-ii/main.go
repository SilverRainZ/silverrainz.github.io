package main

import "fmt"

func removeDuplicates(nums []int) int {
	if len(nums) < 3 {
		return len(nums)
	}
	ptr := 1
	for i := 2; i < len(nums); i++ {
		if nums[i] == nums[ptr] && nums[i] == nums[ptr-1]{
			continue
		} else {
			ptr++
			nums[ptr] = nums[i]
		}
	}
	return ptr+1
}


func main() {
	nums := []int{0,0,1,1,1,1,2,3,3}
	k := removeDuplicates(nums)
	fmt.Println(k)
	fmt.Println(nums[:k])
	nums = []int{0}
	k = removeDuplicates(nums)
	fmt.Println(k)
	fmt.Println(nums[:k])
}
