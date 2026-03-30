package main

import "fmt"

type TreeNode struct {
	Val int
	Left *TreeNode
	Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
	cnt := 1
	return visit(root, k, &cnt)
}

func visit(n *TreeNode, k int, cnt *int) int {
	if n == nil {
		return -1
	}
	if kth := visit(n.Left, k, cnt); kth != -1 {
		return kth
	}
	if *cnt == k {
		return n.Val
	}
	*cnt = *cnt + 1
	return visit(n.Right, k, cnt)
}

func main() {
	fmt.Println("vim-go")
}
