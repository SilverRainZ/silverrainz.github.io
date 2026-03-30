package main

import "fmt"

func searchInsert(nums []int, target int) int {
	return binarySearch(nums, target, 0, len(nums))
}

func binarySearch(nums []int, target int, left, right int) int {
	// fmt.Println("l r", left, right)
	if left == right {
		return left
	}
	mid := (left + right)/2
	if nums[mid] == target {
		return mid
	} else if nums[mid] < target {
		return binarySearch(nums, target, mid+1, right)
	} else {
		return binarySearch(nums, target, left, mid)
	}
}

func main() {
	fmt.Println(searchInsert([]int{1,3,5,6}, 5))
	fmt.Println(searchInsert([]int{1,3,5,6}, 2))
	fmt.Println(searchInsert([]int{1,3,5,6}, 7))
	fmt.Println(searchInsert([]int{1,2,5,6}, 2))
}
