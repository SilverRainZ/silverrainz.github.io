#!/usr/bin/sh
if [ $1 = 't' ]; then
    echo compiling test.c
    gcc -m32 -fno-stack-protector -z norelro -z execstack test.c -o test && 
    echo done.
else
    echo compiling narnia$1.c
    gcc -m32 -fno-stack-protector -z norelro -z execstack narnia$1.c -o narnia$1 && 
    echo done.
fi
