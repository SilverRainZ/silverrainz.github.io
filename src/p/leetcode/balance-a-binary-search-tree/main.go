package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func treeToSortedArray(root *TreeNode) []int {
	if root == nil {
		return []int{}
	}
	arr := treeToSortedArray(root.Left)
	arr = append(arr, root.Val)
	arr = append(arr, treeToSortedArray(root.Right)...)
	return arr
}

func sortedArrayToBST(arr []int) *TreeNode {
	if len(arr) == 0 {
		return nil
	}
	if len(arr) == 1 {
		return &TreeNode{
			Val: arr[0],
		}
	}
	mid := len(arr) / 2
	root := &TreeNode{
		Val: arr[mid],
	}
	root.Left = sortedArrayToBST(arr[:mid])
	root.Right = sortedArrayToBST(arr[mid+1:])
	return root
}

func balanceBST(root *TreeNode) *TreeNode {
	return sortedArrayToBST(treeToSortedArray(root))
}

func main() {
}
