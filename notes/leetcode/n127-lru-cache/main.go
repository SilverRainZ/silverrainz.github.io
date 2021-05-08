package main

import "container/list"

type LRUCache struct {
	capacity int
	recent   *list.List
	elems    map[int]*list.Element
}

type Pair struct {
	Key   int
	Value int
}

func Constructor(capacity int) LRUCache {
	return LRUCache{
		capacity: capacity,
		recent:   list.New(),
		elems:    make(map[int]*list.Element),
	}
}

func (this *LRUCache) Get(key int) int {
	if elem, ok := this.elems[key]; ok {
		this.recent.MoveToFront(elem)
		return elem.Value.(Pair).Value
	} else {
		return -1
	}
}

func (this *LRUCache) Put(key int, value int) {
	pair := Pair{Key: key, Value: value}
	if elem, ok := this.elems[key]; ok {
		elem.Value = pair
		this.recent.MoveToFront(elem)
	} else if len(this.elems) >= this.capacity {
		elem = this.recent.Back()
		delete(this.elems, elem.Value.(Pair).Key)
		elem.Value = pair
		this.recent.MoveToFront(elem)
		this.elems[key] = elem
	} else {
		elem = this.recent.PushFront(pair)
		this.elems[key] = elem
	}
}

/**
* Your LRUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
  * param_1 := obj.Get(key);
   * obj.Put(key,value);
*/
