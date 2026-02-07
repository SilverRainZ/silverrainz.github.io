======
Sphinx
======

.. toctree::
   :titlesonly:

   docutils
   how-sphinx-builder-works
   how-sphinx-index-works

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

intersphinx
===========

查看 Sphindx 文档中可供 intersphinx 索引的 ref
   - https://github.com/webknjaz/intersphinx-untangled
   - https://webknjaz.github.io/intersphinx-untangled/
   - https://webknjaz.github.io/intersphinx-untangled/www.sphinx-doc.org/

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
__ https://www.sphinx-doc.org/en/master/extdev/event_callbacks.html#events
__ https://www.sphinx-doc.org/en/master/_modules/sphinx/config.html#Config
__ https://www.sphinx-doc.org/en/master/extdev/envapi.html
__ https://epydoc.sourceforge.net/docutils/private/docutils.nodes-module.html
__ https://epydoc.sourceforge.net/docutils/private/docutils.nodes.Element-class.html
__ https://docutils.sourceforge.io/docs/howto/rst-directives.html#toc-entry-2
__ https://github.com/docutils-mirror/docutils/blob/master/docutils/parsers/rst/directives/__init__.py#L141-L400
__ https://www.sphinx-doc.org/en/master/extdev/utils.html?highlight=SphinxDirective#sphinx.util.docutils.

测试
~~~~

运行单个测试::

   $ make test TEST=./tests/test_domains/test_domain_py.py::test_deco

Test Fixtures
   :py:meth:`sphinx.testing.fixture.app` 实现了一个 `pytest fixture`__
   能够返回一个测试用的 application 对象 :py:class:`sphinx.testing.utilSphinxTestApp`。

   在 sphinx/tests 目录下直接使用名为 ``app`` 的参数即可使用这个 fixture，例如：

   .. code-block:: python
      :caption: https://github.com/sphinx-doc/sphinx/pull/12514/files

      def test_intersphinx_cache_limit(app):
          url = 'https://example.org/'
          app.config.intersphinx_mapping = {
              'inv': (url, None),
          }
          # ...

__ https://docs.pytest.org/en/latest/explanation/fixtures.html
