package main

import "fmt"

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseBetweenI(head *ListNode, left int, right int, index int) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}
	if index < left {
		head.Next = reverseBetweenI(head.Next, left, right, index+1)
		return head
	} else if index > right-1 {
		return head
	} else {
		rev := reverseBetweenI(head.Next, left, right, index+1)
		succ := head.Next.Next
		head.Next.Next = head
		head.Next = succ
		return rev
	}
}

func reverseBetween(head *ListNode, left int, right int) *ListNode {
	return reverseBetweenI(head, left, right, 1)
}

func main() {
	a := reverseBetween(&ListNode{Val: 1, Next: &ListNode{Val: 2}}, 1, 2)
	for a != nil {
		fmt.Println(a)
		a = a.Next
	}
}
