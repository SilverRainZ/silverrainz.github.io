package main

import "testing"

func TestLRUCache(t *testing.T) {
	lru := Constructor(2)
	lru.Put(1, 1)
	lru.Put(2, 2)
	if lru.Get(1) != 1 {
		t.FailNow()
	}
	lru.Put(3, 3)
	if lru.Get(2) != -1 {
		t.FailNow()
	}
	lru.Put(4, 4)
	if lru.Get(1) != -1 {
		t.FailNow()
	}
	if lru.Get(3) != 3 {
		t.FailNow()
	}
	if lru.Get(4) != 4 {
		t.FailNow()
	}
}
