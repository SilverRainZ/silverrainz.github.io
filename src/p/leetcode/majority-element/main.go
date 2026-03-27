package main

import "fmt"

func majorityElement(nums []int) int {
	var candicate, count int
	for i := 0; i < len(nums); i++ {
		if count == 0 {
			candicate = nums[i]
			count = 1
		} else {
			if candicate == nums[i]  {
				count++
			} else {
				count--
			}
		}
	}
	return candicate
}

func main() {
	fmt.Println(majorityElement([]int{2,2,1,1,1,2,2}))
}
