# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -j auto
SPHINXBUILD   ?= python3 -msphinx
SOURCEDIR     = .
BUILDDIR      = _build
LANG          = en_US.UTF-8
SPHINXSERV    ?= sphinx-autobuild
MAKE          = make

default: fast

view:
	xdg-open "$(BUILDDIR)/html/index.html"

serve:
	$(SPHINXSERV) --no-initial $(SOURCEDIR) $(BUILDDIR)/html

commit:
	git commit -m "$(shell date +'%Y-%m-%d %H:%M')"
	git push

commit-skip-recentupdate:
	git commit -m "[skip-recentupdate] $(shell date +'%Y-%m-%d %H:%M')"
	git push

commit-skip-build:
	git commit -m "[skip ci] $(shell date +'%Y-%m-%d %H:%M')"
	git push

pull:
	git fetch origin master
	git merge origin/master

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: default view help serve commit Makefile snip fast

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Snippet builder: https://sphinx.silverrainz.me/snippet/, for shell completion.
snip: snippet

# Fast HTML builder: https://sphinx.silverrainz.me/fasthtml/
fast: Makefile
	@$(SPHINXBUILD) -b $@html "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS) $(O) -d "$(BUILDDIR)/doctrees"
