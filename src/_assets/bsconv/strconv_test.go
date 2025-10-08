package main

import (
	"strconv"
	"testing"
)

func BenchmarkStrconv(b *testing.B) {
	s := []byte{50, 48, 50, 52, 48, 53}
	for i := 0; i < b.N; i++ {
		_, _ = strconv.ParseInt(string(s), 10, 0)
	}
}
