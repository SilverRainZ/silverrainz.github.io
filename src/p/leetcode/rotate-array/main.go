package main

import "fmt"

func gcd(a, b int) int {
	c := a % b
	if c == 0 {
		return b
	}
	return gcd(b, c)
}

func rotate(nums []int, k int)  {
	n := len(nums)
	if k % n == 0 {
		return
	}

	nLoop := gcd(n, k)

	for i := 0; i < nLoop; i++ {
		rotate1(nums, k, i)
	}
}

func rotate1(nums []int, k int, i int)  {
	n := len(nums)
	ptr := i
	save := nums[i]
	for {
		next := (ptr+k)%n
		tmp := nums[next]
		nums[next] = save
		save = tmp

		ptr = next
		if ptr == i {
			break
		}
	}
}

func main() {
	nums := []int{1,2,3,4,5,6,7}
	rotate(nums, 3)
	fmt.Println(nums) // [5,6,7,1,2,3,4]
	nums = []int{1,2,3,4,5,6,7}
	rotate(nums, 0)
	fmt.Println(nums) // [5,6,7,1,2,3,4]
	rotate(nums, 11)
	fmt.Println(nums) // [5,6,7,1,2,3,4]
}
