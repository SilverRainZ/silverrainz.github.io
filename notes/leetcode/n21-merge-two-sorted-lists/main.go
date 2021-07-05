package main

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
	Val  int
	Next *ListNode
}

func move(from, to *ListNode) (*ListNode, *ListNode) {
	if to != nil {
		to.Next = from
	}
	newFrom := from.Next
	from.Next = nil
	return newFrom, from
}

func mergeTwoLists(l1 *ListNode, l2 *ListNode) *ListNode {
	resHead := ListNode{}
	resTail := &resHead
	for l1 != nil && l2 != nil {
		if l1.Val < l2.Val {
			l1, resTail = move(l1, resTail)
		} else {
			l2, resTail = move(l2, resTail)
		}
	}
	if l1 != nil {
		resTail.Next = l1
	}
	if l2 != nil {
		resTail.Next = l2
	}
	return resHead.Next
}
