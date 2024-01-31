==============
Type Assertion
==============

.. highlight:: go

.. note:: Based on Go 1.17

Assert to 具体类型
==================

比较目标类型和 eface 的 `_typ` 字段，即可转换。

Assert to 带方法的 `interface{}`
================================

以 `i.(fmt.Stringer)` 为例，在 AMD64 平台生成的 指令_ 如下：

.. code:: nasm

           LEAQ    type.fmt.Stringer(SB), AX
           LEAQ    type.int(SB), BX
           CALL    runtime.assertE2I(SB)
           MOVUPS  X15, ""..autotmp_10+40(SP)
           NOP
           TESTQ   AX, AX
           JEQ     main_pc73
           MOVQ    8(AX), AX
   main_pc73:
           MOVQ    AX, ""..autotmp_10+40(SP)
           LEAQ    ""..stmp_0(SB), DX
           MOVQ    DX, ""..autotmp_10+48(SP)
           NOP

`runtime.assertE2I` →  `runtime.getitab`

尝试在 Go 里自己实现一个::

   //go:linkname getitab runtime.getitab
   func getitab(inter uintptr, typ uintptr, _ bool) uintptr

   var rtypeSize uintptr

   func init() {
           rtypeSize = reflect.TypeOf(reflect.TypeOf((1))).Elem().Size()
   }

   func CastInterface[T any](i interface{}) T {
           p := unsafe.Pointer(&i)
           xi := (*xface)(p)
           var z interface{} = (*T)(nil)
           xi.x = getitab(*(*uintptr)(unsafe.Pointer((*xface)(unsafe.Pointer(&z)).x + rtypeSize)), xi.x, false)
           return *(*T)(p)
   }

.. _指令: https://godbolt.org/z/aTo57oxza
