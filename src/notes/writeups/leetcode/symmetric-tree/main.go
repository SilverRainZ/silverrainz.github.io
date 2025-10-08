package main

import "container/list"

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isEqual(l, r *TreeNode) bool {
	if l == nil && r == nil {
		return true
	}
	if l == nil || r == nil {
		return false
	}
	if l.Val != r.Val {
		return false
	}
	return isEqual(l.Left, r.Right) && isEqual(l.Right, r.Left)
}

// 递归解法
func isSymmetric(root *TreeNode) bool {
	return isEqual(root.Left, root.Right)
}

// 迭代解法
func isSymmetric2(root *TreeNode) bool {
	stackL := list.New()
	stackR := list.New()

	// Prevent duplicate compare
	L := root.Left
	R := root.Right

	for L != nil || stackL.Len() != 0 {
		for L != nil {
			if R == nil {
				return false
			}
			stackL.PushBack(L)
			stackR.PushBack(R)
			L = L.Left
			R = R.Right
		}
		if R != nil {
			return false
		}

		if stackL.Back() != nil {
			if stackR.Back() == nil {
				return false
			}
			L = stackL.Remove(stackL.Back()).(*TreeNode)
			R = stackR.Remove(stackR.Back()).(*TreeNode)
			if L.Val != R.Val {
				return false
			}
			if L.Right != nil {
				if R.Left == nil {
					return false
				}
				stackL.PushBack(L.Right)
				stackR.PushBack(R.Left)
			}
			L = L.Right
			R = R.Left
		}
	}
	if R != nil || stackL.Len() != 0 {
		return false
	}

	return true
}

func main() {
}
