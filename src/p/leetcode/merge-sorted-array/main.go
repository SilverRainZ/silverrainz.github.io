package main

func merge(nums1 []int, m int, nums2 []int, n int)  {
	p1, p2 := m-1, n-1
	p := m+n-1
	res := nums1

	for p1 >= 0 && p2 >= 0 {
		if nums1[p1] > nums2[p2] {
			res[p] = nums1[p1] 
			p1--
		} else {
			res[p] = nums2[p2] 
			p2--
		}
		p--
	}

	if p1 < 0 && p2 >= 0 {
		copy(res[0:p+1], nums2[:p2+1])
	}
	if p2 < 0 && p1 <= 0 {
		copy(res[0:p+1], nums1[:p1+1])
	}
}
