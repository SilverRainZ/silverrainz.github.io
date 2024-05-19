#!/bin/bash
set -x

for f in maplookup_test.go equal_test.go; do
    go test -bench . -benchmem $f > ${f%_test.go}.txt
done

./bench_zerocopy.sh
./bench_strconv.sh
