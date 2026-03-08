package main

import "testing"

func TestAddTwoNumbers(t *testing.T) {
	if !addTwoNumbers(nil, nil).Equal((*ListNode)(nil)) {
		t.Fatal("nil test")
	}

	n0 := &ListNode{0, nil}
	if !addTwoNumbers(n0, n0).Equal(n0) {
		t.Fatal("0 test")
	}

	n123 := &ListNode{3, &ListNode{2, &ListNode{1, nil}}}
	n246 := &ListNode{6, &ListNode{4, &ListNode{2, nil}}}
	if !addTwoNumbers(n123, n123).Equal(n246) {
		t.Fatal("123+123 test")
	}

	n999 := &ListNode{9, &ListNode{9, &ListNode{9, nil}}}
	n1 := &ListNode{1, nil}
	n1000 := &ListNode{0, &ListNode{0, &ListNode{0, &ListNode{1, nil}}}}
	if !addTwoNumbers(n999, n1).Equal(n1000) {
		t.Fatal("999+1 test")
	}
}
