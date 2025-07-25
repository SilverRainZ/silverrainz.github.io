# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -j auto
SPHINXBUILD   ?= python3 -msphinx
SPHINXSERV    ?= sphinx-autobuild
SOURCEDIR     = .
BUILDDIR      = _build
LANG          = en_US.UTF-8
MAKE          = make
TS            = $(shell date +'%Y-%m-%d %H:%M')

.PHONY: default
default: fast

################################################################################
# Sphinx Build
################################################################################

.PHONY: help
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
.PHONY: Makefile
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Snippet builder: https://sphinx.silverrainz.me/snippet/, for shell completion.
.PHONY: snip
snip: snippet

# Fast HTML builder: https://sphinx.silverrainz.me/fasthtml/
.PHONY: fast
fast: Makefile
	@$(SPHINXBUILD) -b $@html "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS) $(O) -d "$(BUILDDIR)/doctrees"

################################################################################
# View Helpers
################################################################################

.PHONY: view
view:
	xdg-open "$(BUILDDIR)/html/index.html"

.PHONY: serve
serve:
	cd _utils && ./autobuild

################################################################################
# Git Helpers
################################################################################

.PHONY: status
status:
	@./_utils/git-status

.PHONY: commit
commit:
	# cd .blobs/ && git commit
	git commit -m "$(TS)"
	git push

.PHONY: commit-skip-recentupdate
commit-skip-recentupdate:
	git commit -m "[skip-recentupdate] $(TS)"
	git push

.PHONY: commit-skip-build
commit-skip-build:
	git commit -m "[skip ci] $(TS)"
	git push

.PHONY: pull
pull:
	git fetch origin master
	git merge origin/master

################################################################################
# Misc Utils
################################################################################

.PHONY: migrate-to-permnotes
migrate-to-permnotes:
	./_utils/migrate-to-permnotes
