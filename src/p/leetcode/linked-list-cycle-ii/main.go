package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func detectCycle(head *ListNode) *ListNode {
	if head == nil {
		return nil
	}
	slow, fast := head, head.Next

	for fast != nil && slow != nil {
		if 
	}
	return nil
}

func main() {
	l3 := &ListNode{Val: 3}
	l2 := &ListNode{Val: 2}
	l0 := &ListNode{Val: 0}
	l4 := &ListNode{Val: 4}
	l3.Next = l2
	l2.Next = l0
	l0.Next = l4
	l4.Next = l2
	detectCycle(l3)
}
