package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func swapPairs(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}
	ptr := head
	head = ptr.Next // save head
	var prev *ListNode
	for ptr != nil && ptr.Next != nil {
		next := ptr.Next
		nextnext := next.Next
		if prev != nil {
			prev.Next = next
		}
		next.Next = ptr
		ptr.Next = nextnext
		prev = ptr
		ptr = nextnext
	}
	return head
}

func main() {
}
