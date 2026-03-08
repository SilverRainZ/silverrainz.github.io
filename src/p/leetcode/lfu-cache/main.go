package main

import (
	"container/list"
)

type LFUCache struct {
	capacity int
	store map[int]*Entry // key → entry
	minFreq int
	bucket map[int]*list.List // freq → lru entry list
}

type Entry struct {
	key int
	val int
	freq int
	elem *list.Element
}

func Constructor(capacity int) LFUCache {
	return LFUCache{
		capacity: capacity,
		store: make(map[int]*Entry),
		minFreq: 0,
		bucket: make(map[int]*list.List),
	}
}


func (this *LFUCache) Get(key int) int {
	entry, ok := this.store[key]
	if !ok {
		return -1
	}
	this.touch(entry)
	return entry.val
}

func (this *LFUCache) touch(entry *Entry) {
	oldlist := this.bucket[entry.freq]
	oldlist.Remove(entry.elem)
	if oldlist.Len() == 0 {
		delete(this.bucket, entry.freq)
		if this.minFreq == entry.freq {
			this.minFreq++
		}
	}

	newlist, ok := this.bucket[entry.freq+1]
	if !ok {
		newlist = list.New()
		this.bucket[entry.freq+1] = newlist
	} 
	newelem := newlist.PushFront(entry)
	entry.elem = newelem
	entry.freq++
}

func (this *LFUCache) Put(key int, value int)  {
	entry, ok := this.store[key]
	if ok {
		entry.val = value
		this.touch(entry)
		return
	}

	if this.capacity <= 0 {
		return
	}

	if len(this.store) >= this.capacity {
		lst := this.bucket[this.minFreq]
		entry = lst.Remove(lst.Back()).(*Entry)
		delete(this.store, entry.key)
		if lst.Len() == 0 {
			delete(this.bucket, this.minFreq)
		}
	}

	entry = &Entry {
		key: key,
		val: value,
		freq: 1,
	}
	this.store[key] = entry
	this.minFreq = 1
	lst, ok := this.bucket[1]
	if !ok {
		lst = list.New()
		this.bucket[1] = lst
	}
	elem := lst.PushFront(entry)
	entry.elem = elem
}


/**
 * Your LFUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
 * param_1 := obj.Get(key);
 * obj.Put(key,value);
 */

func main() {
	/**
	 * Your LFUCache object will be instantiated and called as such:
	 */
	//obj := Constructor(10)
	//println(obj.Get(1))
	//obj.Put(1, 1)
	//println(obj.Get(1))

	obj2 := Constructor(2)
	obj2.Put(1, 1)
	obj2.Put(2, 2)
	println(obj2.Get(1)) // touch
	println(obj2.Get(2)) // touch
	obj2.Put(3, 3)
	println(obj2.Get(3))
	println(obj2.Get(2))
	println(obj2.Get(1))
}
