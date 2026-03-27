package main

import "fmt"

func removeElement(nums []int, val int) int {
	ptr := 0;
	for _, v := range nums {
		if v == val {
			continue
		} 
		nums[ptr] = v
		ptr++
	}
	return ptr
}

func main() {
	nums := []int{0,1,2,2,3,0,4,2}
	k := removeElement(nums, 2)
	fmt.Println(nums)
	fmt.Println(k)
}
