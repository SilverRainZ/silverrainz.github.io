echo '// zerocopy=1' > zerocopy.txt
go test -gcflags='-d zerocopy=1 -m' -bench . -benchmem ./zerocopy_test.go \
    1>>zerocopy.txt 2>zerocopy1.log
echo '// zerocopy=0' >> zerocopy.txt
go test -gcflags='-d zerocopy=0 -m' -bench . -benchmem ./zerocopy_test.go \
    1>>zerocopy.txt 2>zerocopy0.log
