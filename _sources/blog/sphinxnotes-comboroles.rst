==================================================================
Implementing "nested inline markup" in reStructuredText and Sphinx
==================================================================

.. post:: 2024-01-14
   :tags: Sphinx, reStructuredText
   :category: Sphinx
   :author: LA
   :language: en
   :location: 杭州

.. highlight:: python

Background
==========

Sphinx is a famous documentation generator used by a lot of Open Source
communities. It uses reStructuredText (hereafter referred to as rST) as markup
language by default.

Unlike Markdown, rST does not yet support `Nested Inline Markups`_, so text
like "bold code" or "italic link" doesn't render as expected:

===================== ================= ===
``**bold**``          **bold**          ✔️
````code````          ``code``          ✔️
````**bold code**```` ``**bold code**`` ❌
``**``bold code``**`` **``bold code``** ❌
===================== ================= ===

In rST, all inline markups are implemented by
`Interpreted Text Roles`_. For example, markup `**foo**` is equivalent to
`:strong:`foo``, "foo" is the interpreted text, and "strong" is the name of
roles, which tells the renderer that "foo" should be highlighted.
The same goes for markup ```foo``` and `:literal:`foo``.

=================================== ============================== ==
``:strong:`bold```                  :strong:`bold`                 ✔️
``:literal:`code```                 :literal:`code`                ✔️
=================================== ============================== ==

Interpreted text can only "be interpreted" once, so markups and roles inside
interpreted text will be treated as plain text, which means the syntax of role
is not nestable either:

=================================== ============================== ==
``:strong:```bold code`````         :strong:```bold code```        ❌
``:literal:`**bold code**```        :literal:`**bold code**`       ❌
``:strong:`:literal:`bold code````  :strong:`:literal:`bold code`` ❌
``:literal:`:strong:`bold code````  :literal:`:strong:`bold code`` ❌
=================================== ============================== ==

Fortunately, rST is extensible, it allows users to create custom roles.
Suppose we can create a role that combines the effects of two existing roles,
then creating "bold code" is possible and it is true:

=============================== =========================== ==
``:strong_literal:`bold code``` :strong_literal:`bold code` ✔️
=============================== =========================== ==

.. _Nested Inline Markups: https://docutils.sourceforge.io/FAQ.html#is-nested-inline-markup-possible
.. _Interpreted Text Roles: https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#interpreted-text

The ``sphinxnotes-comboroles`` extension
========================================

I wrote a Sphinx extension :parsed_literal:`sphinxnotes-comboroles_`,
which can dynamically create composite roles from existing roles.

First, download the extension from PyPI:

.. code:: console

   $ pip install sphinxnotes-comboroles

Then, add the extension name to ``extensions`` configuration item in your ``conf.py``::

   extensions = [
             # …
             'sphinxnotes.comboroles',
             # …
             ]

To create a `strong_literal` role that same as described above, add the following
configuration, which tells the extension to composite example roles
:parsed_literal:`strong` and :parsed_literal:`literal` into a new role
``strong_literal``::

   comboroles_roles = {
       'strong_literal': ['strong', 'literal'],
   }

Finally, you can use it:

=============================== ===========================
``:strong_literal:`bold code``` :strong_literal:`bold code`
=============================== ===========================

.. _sphinxnotes-comboroles: https://sphinx.silverrainz.me/comboroles/

Nested Parse
------------

We have said that markups in interpreted text will not be parsed,
but the extension allows us to force parse the interpreted text, like this::

   comboroles_roles = {
       'parsed_literal': (['literal'], True), # enable nested_parse
   }

The above configuration creates a composite role `parsed_literal` with
`Nested Parse`_ enabled, so the text "\*\*bold code\*\*" can be parsed.

=================================== =============================== ==
````**bold code**````               ``**bold code**``               ❌
``:parsed_literal:`**bold code**``` :parsed_literal:`**bold code**` ✔️
=================================== =============================== ==

Further, hyperlinks, substitutions, and even roles inside interpreted text can
be parsed too:

========================================== =====================================
``:parsed_literal:`https://example.com```` :parsed_literal:`https://example.com`
``:parsed_literal:`|today|````             :parsed_literal:`|today|`
``:parsed_literal:`RFC: :rfc:\`1459\````   :parsed_literal:`RFC: :rfc:\`1459\``
========================================== =====================================

.. note:: For nested roles, the backquote ````` in interpreted text needs to be escaped.

.. _Nested Parse: https://sphinx.silverrainz.me/comboroles/usage.html#nested-parse

Works with other Extensions
---------------------------

Not limited to `Standard Roles`_, The extensions can also work with roles provided
by some other extensions.

.. _Standard Roles: https://docutils.sourceforge.io/docs/ref/rst/roles.html#standard-roles

``sphinx.ext.extlink``
~~~~~~~~~~~~~~~~~~~~~~

:parsed_literal:`sphinx.ext.extlink_` is a Sphinx builtin extension to create
shortened external links.

We have the following configuration, extlink creates the ``issue`` role,
then comboroles creates a ``literal_issue`` role based on it::

   extlinks = {
       'enwiki': ('https://wikipedia.org/wiki/%s', '📖 %s'),
   }

   comboroles_roles = {
       'literal_enwiki': ['literal', 'enwiki'],
   }

============================== ==========================
``:enwiki:`Lo Ta-yu```         :enwiki:`Lo Ta-yu`
``:literal_enwiki:`Lo Ta-yu``` :literal_enwiki:`Lo Ta-yu`
============================== ==========================

.. seealso:: Inspired by https://github.com/sphinx-doc/sphinx/issues/11745

.. _sphinx.ext.extlinks: https://www.sphinx-doc.org/en/master/usage/extensions/extlinks.html

``sphinxnotes.strike``
~~~~~~~~~~~~~~~~~~~~~~

:parsed_literal:`sphinxnotes.strike_` is another extension I wrote, which adds
:del:`strikethrough text` support to Sphinx::

   comboroles_roles = {
      'literal_strike': ['literal', 'strike'],
   }

=========================== ======================
``:strike:`text```          :strike:`text`
``:literal_strike:`text```` :literal_strike:`text`
=========================== ======================

.. _sphinxnotes-strike: https://sphinx.silverrainz.me/strike/

Limitation
----------

.. warning::

   Due to internal implementation, the extension can only used to composite
   simple roles and may CRASH Sphinx when compositing complex roles.
   DO NOT report to Sphinx first if it crashes, please report to
   https://github.com/sphinx-notes/comboroles/issues/new

How it works
============

Someone may be curious how the extension is implemented.
In fact, it is quite simple, about 30 lines of code.

The Docutils Document Tree
--------------------------

Before going further, we need to have some basic understanding of
the `Document Tree <doctree>`_ of docutils [#]_ (hereafter referred to as doctree).
The doctree describes the data structure of a rST document (a `*.rst` file) [#]_.
Here is a simplified diagram of the hierarchy of elements in the doctree,
we only focus on the highlighted lines:

.. code-block:: text
   :emphasize-lines: 11-15
   :caption: Element hierarchy of doctree [#]_

   +--------------------------------------------------------------------+
   | document  [may begin with a title, subtitle, decoration, docinfo]  |
   |                             +--------------------------------------+
   |                             | sections  [each begins with a title] |
   +-----------------------------+-------------------------+------------+
   | [body elements:]                                      | (sections) |
   |         | - literal | - lists  |       | - hyperlink  +------------+
   |         |   blocks  | - tables |       |   targets    |
   | para-   | - doctest | - block  | foot- | - sub. defs  |
   | graphs  |   blocks  |   quotes | notes | - comments   |
   +---------+-----------+----------+-------+--------------+
   | [text]+ | [text]    | (body elements)  | [text]       |
   | (inline +-----------+------------------+--------------+
   | markup) |
   +---------+

The highlight lines describe the content model of `Inline Elements`_.
All inline markups and roles we just discussed belong to inline elements.

   Inline elements *directly contain text data, and may also contain further inline elements*. [#]_

We already know that roles can not contain further roles, so we conclude that:
The limitation of inline nested markup is caused by rST's syntax, rather than
the rST's content model.

By using the :parsed_literal:`rst2pseudoxml_` command line, we can convert
rST source code to text representation of doctree:

.. list-table::
   :header-rows: 1

   - * rST
     * doctree

   - * .. code:: rst

          **bold**  ``code``

     * .. code:: xml

          <document source="untitled.rst">
           <paragraph>
               <strong>
                   bold

               <literal>
                   code

Words enclosed in angle brackets `<` and `>` represent nodes of the doctree,
You can see that role `:strong:`bold`` is converted to a  `<strong>` node in
somehow (see next section) with interpreted text "bold" as its child.

The doctree of "bold code" is a combination of `<strong>` and `literal` node,
which looks like:

.. code:: xml

   <strong>
      <literal>
          bold code

.. _Inline Elements: https://docutils.sourceforge.io/docs/ref/doctree.html#toc-entry-14
.. _doctree: https://docutils.sourceforge.io/docs/ref/doctree.html
.. _rst2pseudoxml: https://docutils.sourceforge.io/docs/user/tools.html#rst2pseudoxml

Dynamic compositing
-------------------

All roles of docutils are implemented in the same way [#]_:

1. Define the Role Function, which receives the context of the parser,
   creates and returns inline elements (nodes),
   and does any additional processing required node.
2. Register the Role, with a name, such as "strong", then users can use it

We can simply create a role function, that returns a fixed combination like
`<strong> <literal> text`, but it is not cool. There may are many combinations of
various markups, I don’t want to implement them one by one. The better idea is:

1. In the function, we look up role functions from a set of role names
   and get the corresponding node by calling them
2. Nesting these nodes together

Note that not all node combinations make sense, it depends on the complexity
role function and the implementation of builders_. Fortunately:

- Most of markups's role function are very simple: They wrap
  `docutils.nodes.TextElement` around the text [#]_
- The most commonly used builder is HTML builder, in its view,
  the combinations of nodes are combinations of HTML tags, which makes sense
  in most cases

.. _builders: https://www.sphinx-doc.org/en/master/usage/builders/index.html

The code implementation
-----------------------

`sphinx.util.docutils.SphinxRole` provides helper methods for creating roles
in Sphinx, we use it instead of defining role function directly::

   class CompositeRole(SphinxRole):
       #: Rolenames to be composited
       rolenames: list[str]

       def __init__(self, rolenames: list[str]):
           self.rolenames = rolenames

The `run` function is equivalent to the role function, but bounded with
the `SphinxRole` subclass we created::

    def run(self) -> tuple[list[Node], list[system_message]]:
       ...

Here we look up role functions. `_roles` and `_role_registr` are unexported
variables of `docutils.parsers.rst.roles` that store the mapping
from role name to role function::

   components = []
   for r in self.rolenames:
       if r in roles._roles:
           components.append(roles._roles[r])
       elif r in roles._role_registry:
           components.append(roles._role_registry[r])
       else:
          # Error handling...

.. note::

   We can not look up up during `__init__`, some roles created by
   3rd-party extension do not exist yet at that time.

Run all role function, pass parameters as is, then collect the returning nodes::

  nodes: list[TextElement] = []
  for comp in components:
      ns, _ = comp(self.name, self.rawtext, self.text, self.lineno, self.inliner, self.options, self.content)
      # Error handling...
      nodes.append(ns[0][0])

The returned nodes should be exactly one `docutils.nodes.TextElement` and
contains exactly one `docutils.nodes.Text` as a child, like this:

.. code:: xml

   <TextElement>
      <Text>

Nesting nodes together by replace the `Text` node with the inner(`i+1`)
`TextElement`::

  for i in range(0, len(nodes) -1):
      nodes[i].replace(nodes[i][0], nodes[i+1])

.. list-table::
   :header-rows: 1

   - * before
     * replace
     * after

   - * .. code:: xml

          i=0: <strong>
                  <text>

          i=1: <literal>
                  <text>
     * .. code:: xml

          i=0: <strong>
                  <text> ◄─┐
                           │ replace
          i=1: <literal>  ─┘
                  <text>
     * .. code:: xml

          i=0: <strong>
                  <literal>
                     <text>

Now, `nodes[0]` is the root of node combination, just return it::

   return [nodes[0]], []

The above code has been simplified for ease of explanation, for complete
implementation, please refer to :ghrepo:`sphinxnotes/comboroles`.

Footnotes
=========

.. [#] docutils_ is the main implementation of reStructuredText
.. [#] It should be easy to understand if you know :enwiki:`Abstract Syntax Tree`
.. [#] `The Docutils Document Tree <doctree>`_ - Element Hierarchy
.. [#] `Inline Elements`_
.. [#] `Creating reStructuredText Interpreted Text Roles <create-roles>`_
.. [#] `Creating reStructuredText Interpreted Text Roles <create-roles>`_ - Generic Roles

.. _docutils: https://docutils.sourceforge.io/
.. _create-roles: https://docutils.sourceforge.io/docs/howto/rst-roles.html
