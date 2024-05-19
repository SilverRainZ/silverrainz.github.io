package main

import "testing"

func BenchmarkMapLookup(b *testing.B) {
	m := map[string]string{
		"foo":                "foo",
		"bar":                "bar",
		"a log string":       "a log string",
		"another log string": "another log string",
	}
	var k = []byte("a looooooooooooooooooooong string")
	b.Run("Optimized", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			_ = m[string(k)]
		}
	})
	b.Run("NotOptimized", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			sk := string(k)
			_ = m[sk]
		}
	})
}
