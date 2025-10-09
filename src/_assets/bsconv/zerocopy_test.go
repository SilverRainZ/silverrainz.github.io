package main

import (
	"testing"
)

func BenchmarkZeroCopy(b *testing.B) {
	s := "202405"
	for i := 0; i < b.N; i++ {
		_ = []byte(s)
	}
}
