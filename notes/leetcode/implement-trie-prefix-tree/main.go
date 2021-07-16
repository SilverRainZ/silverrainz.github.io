package main

type Trie struct {
	Value    byte
	isWord   bool
	Children map[byte]*Trie
}

/** Initialize your data structure here. */
func Constructor() Trie {
	return Trie{
		Children: make(map[byte]*Trie),
	}
}

/** Inserts a word into the trie. */
func (this *Trie) Insert(word string) {
	next, ok := this.Children[word[0]]
	if !ok {
		tmp := Constructor()
		next = &tmp
		next.Value = word[0]
		this.Children[word[0]] = next
	}
	if word[1:] == "" {
		next.isWord = true
	} else {
		next.Insert(word[1:])
	}
}

/** Returns if the word is in the trie. */
func (this *Trie) Search(word string) bool {
	next, ok := this.Children[word[0]]
	if !ok {
		return false
	}
	if word[1:] == "" {
		return next.isWord
	}
	return next.Search(word[1:])
}

/** Returns if there is any word in the trie that starts with the given prefix. */
func (this *Trie) StartsWith(prefix string) bool {
	next, ok := this.Children[prefix[0]]
	if !ok {
		return false
	}
	if prefix[1:] == "" {
		return true
	}
	return next.StartsWith(prefix[1:])
}

func main() {
	/** Your Trie object will be instantiated and called as such: */
	obj := Constructor()
	obj.Insert("artist")
	println(obj.Search("artist"))
	println(obj.Search("artist2"))
	println(obj.Search("artis"))
	println(obj.Search("artisa"))
	println("---")
	println(obj.StartsWith("art"))
	println(obj.StartsWith("artist"))
	println(obj.StartsWith("artist2"))
}
