package main

//  for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func invertTree(root *TreeNode) *TreeNode {
	if root != nil {
		l := root.Left
		r := root.Right
		root.Left = invertTree(r)
		root.Right = invertTree(l)
	}
	return root
}

func main() {

}
