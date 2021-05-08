package main

import "testing"

func TestLFUCache(t *testing.T) {
	lfu := Constructor(2)
	lfu.Put(1, 1)        // cache=[1,_], cnt(1)=1
	lfu.Put(2, 2)        // cache=[2,1], cnt(2)=1, cnt(1)=1
	if lfu.Get(1) != 1 { // return 1
		t.FailNow()
	}
	// cache=[1,2], cnt(2)=1, cnt(1)=2
	lfu.Put(3, 3) // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
	// cache=[3,1], cnt(3)=1, cnt(1)=2
	if lfu.Get(2) != -1 { // return -1 (not found)
		t.FailNow()
	}
	if lfu.Get(3) != 3 { // return 3
		t.FailNow()
	}
	// cache=[3,1], cnt(3)=2, cnt(1)=2
	lfu.Put(4, 4) // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
	// cache=[4,3], cnt(4)=1, cnt(3)=2
	if lfu.Get(1) != -1 { // return -1 (not found)
		t.FailNow()
	}
	if lfu.Get(3) != 3 { // return 3
		t.FailNow()
	}
	// cache=[3,4], cnt(4)=1, cnt(3)=3
	if lfu.Get(4) != 4 { // return 4
		t.FailNow()
	}
	// cache=[3,4], cnt(4)=2, cnt(3)=3
}

func TestLFUCacheCap0(t *testing.T) {
	lfu := Constructor(0)
	lfu.Put(0, 0)
}
