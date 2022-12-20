package main

func TestOutOfRange() {
	s := make([]int, 1, 5)

	// 0 <= low < len(s)
	_ = s[0:] // ✅ OK
	_ = s[1:] // ✅ OK
	// _ = s[2:] // ⚠️  PANIC

	// 0 <= high < cap(s)
	_ = s[:0] // ✅ OK
	_ = s[:2] // ✅ OK
	_ = s[:5] // ✅ OK
	// _ = s[:6] // ⚠️  PANIC
}

func TestExtend() {
	s1 := make([]int, 1, 5)
	s2 := s1[:cap(s1)]

	// [len/cap]addr
	println(s1) // [1/5]0xc000048748
	println(s2) // [5/5]0xc000048748
}

func main() {
	TestOutOfRange()
	TestExtend()
}
