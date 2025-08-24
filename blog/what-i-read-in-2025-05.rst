======================
2025 年 5-8 月我读了什么
======================

.. post:: 2025-05-31
   :tags: 阅读
   :author: LA
   :category: 阅读记录
   :language: zh_CN

`DeepWiki | AI documentation you can talk to, for every repo <https://deepwiki.com/>`_
======================================================================================

- `SrainApp/srain | DeepWiki <https://deepwiki.com/SrainApp/srain>`_
- `sphinx-notes/any | DeepWiki <https://deepwiki.com/sphinx-notes/any>`_
- `sphinx-doc/sphinx | DeepWiki <https://deepwiki.com/sphinx-doc/sphinx>`_

`We Rewrote the Ghostty GTK Application – Mitchell Hashimoto`__
===============================================================

__ https://mitchellh.com/writing/ghostty-gtk-rewrite

Ghostty 完成了对其 GTK 前端的重写：

1. 相比于之前在忽略 ``GObject`` 引用计数的实现，现在项目能够和 GTK/GObject 系统更好的交互，能够享受到 GTK 的生态
2. 作者还使用 Valgrind 对项目进行了内存安全测试，大部分的内存安全问题出现在和 C 代码交互的边界，而 Zig 本身的问题远比作者想象中的少（项目本身用了大量的 hack 以保证性能）。这说明  Zig 本身提供的内存安全保障相当有效，尽管它只在 debug/test 期间发挥作用。
