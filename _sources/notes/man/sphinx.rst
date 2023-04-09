======
Sphinx
======

.. highlight:: console

构建
====

PDF
---

安装 LaTex 依赖:: 

   # pacman -S texlive-most

如果遇到了 `FS#67856`__::

   # pacman -S texlive-langchinese

__ https://bugs.archlinux.org/task/67856

构建::

   $ make latexpdf

文件会生成在 :file:`_build/latex/*.pdf`。

扩展
====

开发
----

文档
~~~~

Spihinx Objects
   - `Sphinx Application API`__
   - `Sphinx Events`__
   - `Config Object`__
   - `Build Environment API`__

Nodes
   - `Docutils Nodes`__
   - `Append child node`__

Directives
   - `Option Oonversion Functions`__
   - `Source Code of option Conversion Functions`__
   - `Sphinx Directive Helper`__

__ https://www.sphinx-doc.org/en/master/extdev/appapi.html
__ https://www.sphinx-doc.org/en/master/extdev/appapi.html#sphinx-core-events
__ https://www.sphinx-doc.org/en/master/_modules/sphinx/config.html#Config
__ https://www.sphinx-doc.org/en/master/extdev/envapi.html
__ http://code.nabla.net/doc/docutils/api/docutils/docutils.nodes.html#module-docutils.nodes
__ http://code.nabla.net/doc/docutils/api/docutils/nodes/docutils.nodes.Element.html#docutils.nodes.Element
__ https://docutils.sourceforge.io/docs/howto/rst-directives.html#toc-entry-2
__ https://github.com/docutils-mirror/docutils/blob/master/docutils/parsers/rst/directives/__init__.py#L141-L400
__ https://www.sphinx-doc.org/en/master/extdev/utils.html?highlight=SphinxDirective#sphinx.util.docutils.
