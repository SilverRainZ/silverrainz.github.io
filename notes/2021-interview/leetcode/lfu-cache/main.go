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

// ----------------------------------------------------------------------------

type LFUCache2 struct {
	capacity int
	elems    map[int]*list.Element
	freq     map[int]*list.List
	min      int
}

func Constructor2(capacity int) LFUCache2 {
	return LFUCache2{
		capacity: capacity,
		freq:     make(map[int]*list.List),
		elems:    make(map[int]*list.Element),
	}
}

func (this *LFUCache2) Get(key int) int {
	if elem, ok := this.elems[key]; ok {
		this.touch(elem)
		return elem.Value.(*Pair).Value
	} else {
		return -1
	}
}

func (this *LFUCache2) touch(elem *list.Element) {
	pair := elem.Value.(*Pair)
	oldList := this.freq[pair.Freq]
	oldList.Remove(elem)
	if oldList.Len() == 0 && pair.Freq == this.min {
		this.min++
	}

	// Incr fre
	pair.Freq++
	newList, ok := this.freq[pair.Freq]
	if !ok {
		newList = list.New()
		this.freq[pair.Freq] = newList
	}
	newElem := newList.PushFront(pair)
	this.elems[pair.Key] = newElem
}

func (this *LFUCache2) Put(key int, value int) {
	if this.capacity == 0 {
		return
	}
	// println("put", key, value)
	if elem, ok := this.elems[key]; ok {
		this.touch(elem)
		elem.Value.(*Pair).Value = value
		return
	}

	if len(this.elems) >= this.capacity {
		lst := this.freq[this.min]
		oldElem := lst.Back()
		// println("pop", oldElem.Value.(*Pair).Key)
		delete(this.elems, oldElem.Value.(*Pair).Key)
		lst.Remove(oldElem)
	}

	this.min = 1
	pair := Pair{Key: key, Value: value, Freq: 1}
	lst, ok := this.freq[1]
	if !ok {
		lst = list.New()
		this.freq[1] = lst
	}
	elem := lst.PushFront(&pair)
	this.elems[key] = elem
}

func main() {
	/**
	 * Your LFUCache object will be instantiated and called as such:
	 */
	//obj := Constructor(10)
	//println(obj.Get(1))
	//obj.Put(1, 1)
	//println(obj.Get(1))

	obj2 := Constructor2(2)
	obj2.Put(1, 1)
	obj2.Put(2, 2)
	println(obj2.Get(1)) // touch
	println(obj2.Get(2)) // touch
	obj2.Put(3, 3)
	println(obj2.Get(3))
	println(obj2.Get(2))
	println(obj2.Get(1))
}
