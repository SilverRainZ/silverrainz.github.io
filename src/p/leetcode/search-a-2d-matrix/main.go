package main

import "fmt"

func searchMatrix(matrix [][]int, target int) bool {
	return binarySearch(matrix, target, 0, len(matrix) * len(matrix[0]))
}

func access(matrix [][]int, i int) int {
	N := len(matrix[0])
	m, n := i/N, i%N
	return matrix[m][n]
}

func binarySearch(matrix [][]int, target int, left, right int) bool {
	if left == right {
		return false
	}
	mid := (left + right) / 2
	v := access(matrix, mid) 
	if v == target {
		return true
	} else if v > target {
		return binarySearch(matrix, target, left, mid)
	} else {
		return binarySearch(matrix, target, mid+1, right)
	}
}

func main() {
	fmt.Println(searchMatrix([][]int{{1}}, 2))
}
