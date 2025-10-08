粗略统计 Go Packages 的公开函数::

   grep -r '^func [A-Z]' --exclude-dir internal --exclude '*_test.go'
