==============
Go's Assembler
==============

.. highlight:: nasm

.. contents::
   :local:

.. seealso:: 

   - `A Quick Guide to Go's Assembler <https://golang.org/doc/asm>`_
   - `Plan 9 assemblers <https://9p.io/sys/doc/asm.html>`_

- Go's assembler is that it is not a direct representation of the underlying machine: It is chosen to match what the compiler generates

Tools
=====

View compiler asm (semi-abstract instruction set):

.. code:: console

   $ GOOS=linux GOARCH=amd64 go tool compile -S x.go

View executable asm (machine instruction set): (r u sure???)

.. code:: console

   $ go build -o x.o x.go
   $ go tool objdump -s main.main x.exe

Syntax
======

Symbols
-------

Registers
   Like R1, LR, which depends on the architecture.

   All pre-defined symbols in the assembler are upper-case:

   - Data registers are `R0` through `R7`
   - Address registers are `A0` through `A7`
   - Floating-point registers are `F0` through `F7`

Pseudo Registers
   :FP: Frame pointer: arguments and locals
   :PC: Program counter: jumps and branches
   :SB: Static base pointer: global symbols
   :SP: Stack pointer: the highest address within the local stack frame (Top of stack?)

   All user-defined symbols are written as offsets to the pseudo-registers `FP` and `SB`.

Global Symbols
   :foo(SB): Address of global symbol `foo`
   :foo<>(SB): Same as above, but visible only in the current source file
   :foo+4(SB): With 4 bytes offset

Function Arguments
   :foo+0(FP): The first function argument named "foo"
   :bar+8(FP): The second Function argument named "bar" (on a 64-bit machine),

   .. note:: 

      The meaning of the offset -- offset from the frame pointer -- distinct from its use with SB, where it is an offset from the symbol


Local Symbols
   :x-8(SP): The local variable named "x"
   :x+8(SP): The function argument named "x"

   Positive offsets (`+`) for function argument and negative offsets (`-`) for local variable. `SP` points to the highest address within the local stack frame

   .. note:: 

      On architectures with a hardware register named SP, x-8(SP) and -8(SP) are different memory locations:

      - the first refers to the virtual stack pointer pseudo-register
      - while the second refers to the hardware's SP register

      让人容易混淆的约定……

Branch
    Branches and direct jumps are always written as offsets to the PC, or as jumps to labels.

Directives
----------

FUNCDATA, PCDATA 
   Contain information for use by the garbage collector; they are introduced by the compiler. 

TEXT
   Define function symbol::

      TEXT runtime·profileloop(SB),NOSPLIT,$8
              MOVQ	$runtime·profileloop1(SB), CX         ; Body of the function
              MOVQ	CX, 0(SP)
              CALL	runtime·externalthreadhandler(SB)
              RET                                        ; Last instruction

   :runtime·profileloop(SB): Global symbol name
   :NOSPLIT: Flag. If `NOSPLIT` is not specified, the argument size (see below )must be provided. 
   :$8: Usually in form `$FLAME_SIZE-ARG_SIZE`, which live on the caller's frame, in this example, `ARG_SIZE` is not provided.
   :RET: The last instruction in a TEXT block must be some sort of jump, usually a `RET` (pseudo-)instruction.
         (If it's not, the linker will append a jump-to-itself instruction; there is no fallthrough in TEXTs.)

DATA
   Define a data symbols::

      DATA  symbol+offset(SB)/width, value      ; Global
      ; or
      DATA  symbol<>+offset(SB)/width, value    ; Local

   Which initializes the symbol memory at the given offset and width with the given value.

GLOBAL
    Declares a symbol to be global.

    The arguments are optional flags and the size of the data being declared as a global.

Flags
   See textflag.h_


   列一些我们关心的：

   NOSPLIT = 4
      (For TEXT items.) Don't insert the preamble to check if the stack must be split. The frame for the routine, plus anything it calls, must fit in the spare space remaining in the current stack segment. Used to protect routines such as the stack splitting code itself. 

      运行时不进行栈扩展（有人用溢出，这可能引发歧义）。
      对需要扩展栈的函数（stack frame 过大）使用此 flag，会导致编译失败


   NOPTR = 16
      (For DATA and GLOBL items.) This data contains no pointers and therefore does not need to be scanned by the garbage collector. 

   .. _textflag.h: https://github.com/golang/go/blob/master/src/runtime/textflag.h
   

Instructions
------------

Like GAS, Left-to-right assignment.

MOVE
   Does not distinguish between the various forms of MOVE instruction: move quick, move address, etc

NOP
    It is a pseudo-instruction means NO INSTRUCTION AT ALL, rather than an instruction that does nothing.

Interacting with Go 
-------------------

If a package has any `.s` files, then go build will direct the compiler to emit a special header called `go_asm.h`, which the `.s` files can then `#include`. The file contains symbolic `#define` constants for the offsets of Go struct fields, the sizes of Go struct types, and most Go const declarations defined in the current package.

- Constants are of the form const_name: `const bufSize = 1024` -> `const_bufSize`
- Field offsets are of the form type_field. `type reader struct { r int }` -> `reader_r`

Runtime Coordination 
--------------------

.. todo:: TODO

Architecture-specific Details
-----------------------------

amd64
~~~~~

- Uses `MOVQ` rather than `MOVL`
- Register `BP` is callee-save. Using BP as a general purpose register is allowed, however it can interfere with sampling-based profiling. 
