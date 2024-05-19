#!/bin/bash
set -x

echo '// go1.22' > strconv.txt
go test -gcflags='-m' -bench . -benchmem ./strconv_test.go \
    1>>strconv.txt 2>strconv122.log
echo '// go1.19' >> strconv.txt
go1.19 test -gcflags='-m' -bench . -benchmem ./strconv_test.go \
    1>>strconv.txt 2>strconv119.log
