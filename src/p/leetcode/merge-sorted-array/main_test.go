package main

import (
	"reflect"
	"testing"
)

func TestMerge(t *testing.T) {
	tests := []struct {
		name     string
		nums1    []int
		m        int
		nums2    []int
		n        int
		expected []int
	}{
		{
			name:     "basic merge",
			nums1:    []int{1, 2, 3, 0, 0, 0},
			m:        3,
			nums2:    []int{4, 5, 6},
			n:        3,
			expected: []int{1, 2, 3, 4, 5, 6},
		},
		{
			name:     "basic merge1",
			nums1:    []int{4, 5, 6, 0, 0, 0},
			m:        3,
			nums2:    []int{1, 2, 3},
			n:        3,
			expected: []int{1, 2, 3, 4, 5, 6},
		},
		{
			name:     "basic merge2",
			nums1:    []int{1, 2, 3, 0, 0, 0},
			m:        3,
			nums2:    []int{2, 5, 6},
			n:        3,
			expected: []int{1, 2, 2, 3, 5, 6},
		},
		{
			name:     "basic merge3",
			nums1:    []int{4, 5, 6, 0, 0, 0},
			m:        3,
			nums2:    []int{1, 2, 10},
			n:        3,
			expected: []int{1, 2, 4, 5, 6, 10},
		},
		{
			name:     "nums1 is empty",
			nums1:    []int{0, 0, 0},
			m:        0,
			nums2:    []int{1, 2, 3},
			n:        3,
			expected: []int{1, 2, 3},
		},
		{
			name:     "nums2 is empty",
			nums1:    []int{1, 2, 3},
			m:        3,
			nums2:    []int{},
			n:        0,
			expected: []int{1, 2, 3},
		},
		{
			name:     "all nums2 elements smaller",
			nums1:    []int{4, 5, 6, 0, 0, 0},
			m:        3,
			nums2:    []int{1, 2, 3},
			n:        3,
			expected: []int{1, 2, 3, 4, 5, 6},
		},
		{
			name:     "all nums1 elements smaller",
			nums1:    []int{1, 2, 3, 0, 0, 0},
			m:        3,
			nums2:    []int{4, 5, 6},
			n:        3,
			expected: []int{1, 2, 3, 4, 5, 6},
		},
		{
			name:     "single element merge",
			nums1:    []int{1, 0},
			m:        1,
			nums2:    []int{0},
			n:        1,
			expected: []int{0, 1},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			nums1Copy := make([]int, len(tt.nums1))
			copy(nums1Copy, tt.nums1)
			merge(nums1Copy, tt.m, tt.nums2, tt.n)
			if !reflect.DeepEqual(nums1Copy, tt.expected) {
				t.Errorf("merge() = %v, want %v", nums1Copy, tt.expected)
			}
		})
	}
}
