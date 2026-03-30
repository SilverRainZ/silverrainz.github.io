package main

import "fmt"
import "math"

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

func getMinimumDifference(root *TreeNode) int {
	prev := -1
	min := math.MaxInt
	visit(root, &prev, &min)
	return min
}

func visit(n *TreeNode, prev *int, min *int) {
	if n == nil {
		return 
	}
	visit(n.Left, prev, min)
	// fmt.Println("visit:", n.Val, "prev:", *prev)
	if *prev != -1 {
		v := n.Val - *prev
		if *min > v {
			*min = v
		}
	}
	*prev = n.Val
	visit(n.Right, prev, min)
}

func main() {
	fmt.Println("Hello, World!")
}
