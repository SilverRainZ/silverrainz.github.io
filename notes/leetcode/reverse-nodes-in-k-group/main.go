package main

import "fmt"

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

// revHead, revTail, ok
func reverseFirstKGroup(head *ListNode, k int) (*ListNode, *ListNode, bool) {
	if k == 0 {
		return head, nil, true
	}
	if head.Next == nil {
		return head, nil, false
	}
	rev, _, ok := reverseFirstKGroup(head.Next, k-1)
	if !ok {
		return head, nil, ok
	}
	tmp := head.Next.Next
	head.Next.Next = head
	head.Next = tmp
	return rev, head, ok
}

func reverseKGroup(head *ListNode, k int) *ListNode {
	var newHead *ListNode
	var prevTail *ListNode
	next := head
	for next != nil {
		var tail *ListNode
		next, tail, _ = reverseFirstKGroup(next, k-1)
		if newHead == nil {
			newHead = next
		}
		if prevTail != nil {
			prevTail.Next = next
		}
		prevTail = tail
		if tail == nil {
			break
		}
		next = tail.Next
	}
	return newHead
}

func print(l *ListNode) {
	if l != nil {
		fmt.Printf("%d ->", l.Val)
		print(l.Next)
	} else {
		fmt.Println("nil")
	}
}

func main() {
	print(reverseKGroup(&ListNode{Val: 1}, 1))
	print(reverseKGroup(&ListNode{1, &ListNode{Val: 2}}, 1))
	print(reverseKGroup(&ListNode{1, &ListNode{Val: 2}}, 2))
	print(reverseKGroup(&ListNode{1, &ListNode{2, &ListNode{3, &ListNode{4, &ListNode{Val: 5}}}}}, 1))
	print(reverseKGroup(&ListNode{1, &ListNode{2, &ListNode{3, &ListNode{4, &ListNode{Val: 5}}}}}, 2))
	print(reverseKGroup(&ListNode{1, &ListNode{2, &ListNode{Val: 3}}}, 2))
}
