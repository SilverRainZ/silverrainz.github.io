package main

// Definition for singly-linked list.
type ListNode struct {
	Val  int
	Next *ListNode
}

func detectCycle(head *ListNode) *ListNode {
	fast := head
	slow := head

	for fast != nil {
		slow = slow.Next
		if fast.Next == nil {
			return nil
		}
		fast = fast.Next.Next
		// println(fast.Val, slow.Val)
		if slow == fast {
			// cycle detected
			ptr := head
			for ptr != slow {
				// println(ptr.Val, slow.Val)
				ptr = ptr.Next
				slow = slow.Next
			}
			return ptr
		}
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
