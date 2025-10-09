package main

import (
	"bytes"
	"testing"
)

func BenchmarkEqual(b *testing.B) {
	bs1 := []byte("a looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong string")
	bs2 := []byte("a looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong string2")

	b.Run("Optimized", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			_ = string(bs1) == string(bs2)
		}
	})
	b.Run("NotOptimized", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			s1 := string(bs1)
			s2 := string(bs2)
			_ = s1 == s2
		}
	})
	b.Run("Optimized2", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			_ = string(bs1) >= string(bs2)
		}
	})
	b.Run("bytes.Equal", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			_ = bytes.Equal(bs1, bs2)
		}
	})
}
