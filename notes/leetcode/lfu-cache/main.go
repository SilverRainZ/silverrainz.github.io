package main

import "container/list"

type Pair struct {
	Key   int
	Value int
	Freq  int
}
type LFUCache struct {
	capacity int
	freq     *list.List
	elems    map[int]*list.Element
}

func Constructor(capacity int) LFUCache {
	return LFUCache{
		capacity: capacity,
		freq:     list.New(),
		elems:    make(map[int]*list.Element),
	}
}

func (this *LFUCache) Get(key int) int {
	if elem, ok := this.elems[key]; ok {
		this.touch(elem)
		return elem.Value.(*Pair).Value
	} else {
		return -1
	}
}

func (this *LFUCache) touch(elem *list.Element) {
	elem.Value.(*Pair).Freq += 1
	// println("touch", elem.Value.(*Pair).Value, elem.Value.(*Pair).Freq)
	for e := elem.Prev(); e != nil; e = e.Prev() {
		if e.Value.(*Pair).Freq <= elem.Value.(*Pair).Freq {
			// println("move", elem.Value.(*Pair).Value, "before", e.Value.(*Pair).Value)
			// println("freq", elem.Value.(*Pair).Freq, e.Value.(*Pair).Freq)
			this.freq.MoveBefore(elem, e)
		}
	}
}

func (this *LFUCache) Put(key int, value int) {
	// println("put", key, value)
	pair := Pair{Key: key, Value: value, Freq: 0}
	if elem, ok := this.elems[key]; ok {
		this.touch(elem)
		elem.Value.(*Pair).Value = value
	} else if len(this.elems) >= this.capacity {
		if this.capacity == 0 {
			return
		}
		oldElem := this.freq.Back()
		// println("pop", oldElem.Value.(*Pair).Key)
		delete(this.elems, oldElem.Value.(*Pair).Key)
		this.freq.Remove(oldElem)
		elem := this.freq.PushBack(&pair)
		this.touch(elem)
		this.elems[key] = elem
	} else {
		elem := this.freq.PushBack(&pair)
		this.touch(elem)
		this.elems[key] = elem
	}
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
 * param_1 := obj.Get(key);
 * obj.Put(key,value);
 */
