package main

// import "fmt"

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

func maxSubArray_Conquer(nums []int, left bool) (int, int) {
	if len(nums) == 1 {
		// fmt.Println(nums, nums[0], nums[0], left)
		return nums[0], nums[0]
	}
	lmax, lmid := maxSubArray_Conquer(nums[:len(nums)/2], true)
	rmax, rmid := maxSubArray_Conquer(nums[len(nums)/2:], false)
	max := lmid + rmid
	if lmax > max {
		max = lmax
	}
	if rmax > max {
		max = rmax
	}
	var mid int
	if left {
		var tmp int
		mid = nums[len(nums)-1]
		for i := len(nums) - 1; i >= 0; i-- {
			tmp += nums[i]
			if tmp > mid {
				mid = tmp
			}
		}
	} else {
		var tmp int
		mid = nums[0]
		for i := 0; i < len(nums); i++ {
			tmp += nums[i]
			if tmp > mid {
				mid = tmp
			}
		}
	}

	// fmt.Println(nums, max, mid, left)
	return max, mid
}

func maxSubArray_Divide(nums []int) int {
	max, _ := maxSubArray_Conquer(nums, true)
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

	println("------------")

	println(maxSubArray_Divide([]int{-2, 1, -3, 4, -1, 2, 1, -5, 4}))
	println(maxSubArray_Divide([]int{-1, -1, -1, -1}))
	println(maxSubArray_Divide([]int{1}))
	println(maxSubArray_Divide([]int{1, 2, 3}))
	println(maxSubArray_Divide([]int{1, 2, 3, -1}))
	println(maxSubArray_Divide([]int{-1, 1, 2, 3, -1}))
	println(maxSubArray_Divide([]int{-2, -3, -1}))
	println(maxSubArray_Divide([]int{8, -19, 5, -4, 20}))
}
