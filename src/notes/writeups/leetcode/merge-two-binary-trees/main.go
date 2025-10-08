package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func mergeTrees(root1 *TreeNode, root2 *TreeNode) *TreeNode {
	if root1 == nil && root2 == nil {
		return nil
	}
	root3 := &TreeNode{}
	var l1, r1, l2, r2 *TreeNode
	if root1 != nil {
		root3.Val = root1.Val
		l1 = root1.Left
		r1 = root1.Right
	}
	if root2 != nil {
		root3.Val += root2.Val
		l2 = root2.Left
		r2 = root2.Right
	}
	root3.Left = mergeTrees(l1, l2)
	root3.Right = mergeTrees(r1, r2)
	return root3
}

func main() {
}
