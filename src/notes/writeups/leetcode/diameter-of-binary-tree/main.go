package main

import (
	"sort"
)

var res int

func maxInts(s ...int) int {
	sort.Ints(s)
	return s[len(s)-1]
}

// Return (left, right)
func armSpan(root *TreeNode) (int, int) {
	var L, R int
	ints := []int{res}
	if root.Left != nil {
		ll, lr := armSpan(root.Left)
		L = maxInts(ll, lr) + 1
	}
	if root.Right != nil {
		rl, rr := armSpan(root.Right)
		R = maxInts(rl, rr) + 1
	}

	ints = append(ints, L+R)
	res = maxInts(ints...)
	// println("node", root.Val, L, R)
	return L, R
}

func diameterOfBinaryTree(root *TreeNode) int {
	res = 0
	armSpan(root)
	return res
}

// Return (left, right)
func armSpan2(root *TreeNode) (int, int) {
	var L, R int
	if root.Left != nil {
		ll, lr := armSpan2(root.Left)
		L = maxInts(ll, lr) + 1
	}
	if root.Right != nil {
		rl, rr := armSpan2(root.Right)
		R = maxInts(rl, rr) + 1
	}

	ints := []int{res}
	ints = append(ints, L+R)
	res = maxInts(ints...)
	// println("node", root.Val, L, R)
	return L, R
}

func diameterOfBinaryTree2(root *TreeNode) int {
	res = 0
	armSpan2(root)
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

// Return (left, right)

func diameterOfBinaryTree3(root *TreeNode) int {
	res = 0
	depth(root)
	return res
}

func depth(root *TreeNode) int {
	if root == nil {
		return 0
	}
	L := depth(root.Left)
	R := depth(root.Right)
	res = max(res, L+R)
	return max(L, R) + 1
}

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
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

	t2 := &TreeNode{
		Val: 1,
		Left: &TreeNode{
			Val: 2,
		},
		Right: &TreeNode{
			Val: 3,
			Left: &TreeNode{
				Val: 4,
			},
		},
	}
	println(diameterOfBinaryTree(t2))
}
