# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
LANG          = en_US.UTF-8
SPHINXSERV    ?= sphinx-autobuild

default: html

view:
	xdg-open "$(BUILDDIR)/html/index.html"

serve:
	$(SPHINXSERV) --no-initial $(SOURCEDIR) $(BUILDDIR)/html

commit:
	git commit -m "$(shell date +'%Y-%m-%d %H:%M')"
	git push

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: default view help serve commit Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
