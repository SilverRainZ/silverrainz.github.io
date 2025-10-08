package main

import (
	"container/list"
	"fmt"
)

// for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseList(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}
	rev := reverseList(head.Next)
	head.Next.Next = head
	head.Next = nil
	return rev
}

func reverseList2(head *ListNode) *ListNode {
	stack := list.New()
	for head != nil {
		stack.PushBack(head)
		tmp := head.Next
		head.Next = nil
		head = tmp
	}
	var prev *ListNode
	for stack.Back() != nil {
		tmp := stack.Remove(stack.Back()).(*ListNode)
		if prev != nil {
			prev.Next = tmp
			prev = tmp
		}
		if head == nil {
			head = tmp
			prev = tmp
		}
	}
	return head
}

func main() {
	a := reverseList(&ListNode{Val: 1, Next: &ListNode{Val: 2}})
	for a != nil {
		fmt.Println(a)
		a = a.Next
	}
	a = reverseList2(&ListNode{Val: 1, Next: &ListNode{Val: 2}})
	for a != nil {
		fmt.Println(a)
		a = a.Next
	}
}
