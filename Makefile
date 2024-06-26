# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
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

.PHONY: default view help serve commit Makefile snip fast live full

# Standard HTML builder.
full: html

# Snippet builder: https://sphinx.silverrainz.me/snippet/
snip: snippet

# Live HTML builder: https://sphinx.silverrainz.me/livehtml/
fast: fasthtml
live: livehtml

# Catch-all target: route all unknown targets to Sphinx builder.
# $(O) is meant as a shortcut for $(SPHINXOPTS).
#
# NOTE: We want the html, fasthtml and livehtml builders share same outdir.
#
# 	1. Don't use the make mode (-M) because it force use $(BUILDDIR)/$(BUILDERNAME)
# 		as outdir
# 	2. The $(if $(findstring ...)) expr returns correct outdir for us
# 		if "html" found in builder name, return "html", otherwise return the
# 		builder name
%: Makefile
	@$(SPHINXBUILD) -b $@ "$(SOURCEDIR)" "$(BUILDDIR)/$(if $(findstring html,$@),html,$@)" $(SPHINXOPTS) $(O) 
