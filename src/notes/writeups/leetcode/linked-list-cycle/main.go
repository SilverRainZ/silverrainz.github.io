package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func hasCycle(head *ListNode) bool {
	if head == nil {
		return false
	}
	head1 := head.Next
	for head != nil && head1 != nil {
		if head == head1 {
			return true
		}
		if head1.Next == nil {
			return false
		}
		head = head.Next
		head1 = head1.Next.Next
	}
	return false
}

func main() {
}
