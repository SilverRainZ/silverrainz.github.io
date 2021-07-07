package main

import (
	"fmt"
	"sort"
)

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

var max int

func maxInts(s ...int) int {
	if len(s) == 5 {
		fmt.Println("Before sort", s)
		fmt.Println("After sort", s)
	}
	sort.Ints(s)
	return s[len(s)-1]
}

func armSpan(root *TreeNode) (int, int) {
	var ll, lr, rl, rr, L, R int
	ints := []int{max}
	if root.Left != nil {
		ll, lr := armSpan(root.Left)
		L = maxInts(ll, lr) + 1
		ints = append(ints, ll+lr)
	}
	if root.Right != nil {
		rl, rr := armSpan(root.Right)
		R = maxInts(rl, rr) + 1
		ints = append(ints, rl+rr)
	}

	if root.Left != nil && root.Right != nil {
		ints = append(ints, ll+rl+2, ll+rr+2, lr+rl+2, lr+rr+2)
	}
	max = maxInts(ints...)

	return L, R
}

func diameterOfBinaryTree(root *TreeNode) int {
	armSpan(root)
	return max
}

func diameterOfBinaryTree2(root *TreeNode) int {
	if root == nil {
		return 0
	}
	var l, r int
	var ints []int
	if root.Left != nil {
		l = diameterOfBinaryTree2(root.Left)
		ints = append(ints, l+1)
	}
	if root.Right != nil {
		r = diameterOfBinaryTree2(root.Left)
	}
	max = maxInts(max)
	return max
}

func main() {
	t1 := &TreeNode{
		Val: 1,
		Left: &TreeNode{
			Val: 2,
			Left: &TreeNode{
				Val: 4,
			},
			Right: &TreeNode{
				Val: 5,
			},
		},
		Right: &TreeNode{
			Val: 3,
		},
	}
	println(diameterOfBinaryTree(t1))

}
