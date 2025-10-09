package main

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
	Val  int
	Next *ListNode
}

func (self *ListNode) Equal(n *ListNode) bool {
	if self == nil || n == nil {
		// println(self, n, self == nil, n == nil, self == nil && n == nil)
		return self == nil && n == nil
	}
	if self.Val != n.Val {
		// println(self.Val, "!=", n.Val)
		return false
	}
	return self.Next.Equal(n.Next)
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	head := &ListNode{}
	cur := head
	var carry int
	for {
		val := carry
		end := true
		if l1 != nil {
			val += l1.Val
			l1 = l1.Next
			end = false
		}
		if l2 != nil {
			val += l2.Val
			l2 = l2.Next
			end = false
		}
		if end {
			break
		}
		carry = val / 10
		cur.Next = &ListNode{
			Val: val % 10,
		}
		// println("val", cur.Val)
		cur = cur.Next
	}

	if carry != 0 {
		cur.Next = &ListNode{
			Val: carry,
		}
		// println("carry val", cur.Val)
	}

	return head.Next
}
