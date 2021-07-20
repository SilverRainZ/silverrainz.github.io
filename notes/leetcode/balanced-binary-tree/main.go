package main

import "fmt"

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}
func abs(a int) int {
	if a < 0 {
		return -a
	} else {
		return a
	}
}

func isBalancedRec(root *TreeNode) (bool, int) {
	if root == nil {
		return true, 0
	}
	okL := true
	depthL := 0
	if root.Left != nil {
		okL, depthL = isBalancedRec(root.Left)
		depthL += 1
	}
	if !okL {
		return false, 0
	}
	okR := true
	depthR := 0
	if root.Right != nil {
		okR, depthR = isBalancedRec(root.Right)
		depthR += 1
	}
	if !okR {
		return false, 0
	}
	return abs(depthR-depthL) <= 1, max(depthL, depthR)
}

func isBalanced(root *TreeNode) bool {
	ok, _ := isBalancedRec(root)
	return ok
}

func main() {
	fmt.Println("vim-go")
}
