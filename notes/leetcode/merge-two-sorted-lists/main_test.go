package main

import "testing"

func arrayToLinkList(a []int) *ListNode {
	head := ListNode{}
	tail := &head
	for _, i := range a {
		tail.Next = &ListNode{Val: i}
		tail = tail.Next
	}
	return head.Next
}

func isEqual(a []int, l *ListNode) bool {
	idx := 0
	for l != nil {
		if len(a) < idx+1 {
			println(len(a), '<', idx+1)
			return false
		}
		if l.Val != a[idx] {
			println(l.Val, "!=", a[idx])
			return false
		}
		l = l.Next
		idx += 1
	}
	if idx != len(a) {
		return false
	}
	return true
}

func TestMergeTwoLists(t *testing.T) {
	list123 := arrayToLinkList([]int{1, 2, 3})
	if !isEqual([]int{1, 2, 3}, list123) {
		t.FailNow()
	}
	if isEqual([]int{1, 2, 3, 4}, list123) {
		t.FailNow()
	}
	if isEqual([]int{1, 2}, list123) {
		t.FailNow()
	}

	if !isEqual([]int{1, 1, 2, 3, 4, 4},
		mergeTwoLists(
			arrayToLinkList([]int{1, 2, 4}),
			arrayToLinkList([]int{1, 3, 4}),
		)) {

		t.FailNow()
	}

	if !isEqual([]int{1, 2, 4},
		mergeTwoLists(
			arrayToLinkList([]int{1, 2, 4}),
			arrayToLinkList([]int{}),
		)) {

		t.FailNow()
	}

	if !isEqual([]int{},
		mergeTwoLists(
			arrayToLinkList([]int{}),
			arrayToLinkList([]int{}),
		)) {

		t.FailNow()
	}
}
