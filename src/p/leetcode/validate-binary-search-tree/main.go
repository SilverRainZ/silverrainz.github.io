package main

import "fmt"

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

func isValidBST(root *TreeNode) bool {
	var prev *int
	return visit(root, &prev)
}

func visit(n *TreeNode, prev **int) bool {
	if n == nil {
		return true
	}
	if !visit(n.Left, prev) {
		return false
	}
	if *prev != nil {
		if **prev >= n.Val {
			return false
		}
	}
	*prev = &n.Val
	return visit(n.Right, prev)
}

func main() {
	fmt.Println("vim-go")
}
