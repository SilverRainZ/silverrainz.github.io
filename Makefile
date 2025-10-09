# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -j auto
SPHINXBUILD   ?= python3 -msphinx
SPHINXSERV    ?= sphinx-autobuild
CONFIGDIR     = .
SOURCEDIR     = src
BUILDDIR      = build
LANG          = en_US.UTF-8
MAKE          = make
RM            = rm -rf
TS            = $(shell date +'%Y-%m-%d %H:%M')

.PHONY: default
default: fast

################################################################################
# Sphinx Build
################################################################################

.PHONY: help
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: clean
clean:
	@$(RM) $(BUILDDIR)

# Catch-all target: route all unknown targets to Sphinx builder name.
# $(O) is meant as a shortcut for $(SPHINXOPTS).
.PHONY: Makefile
%: Makefile
	@$(SPHINXBUILD) -b $@ -c "$(CONFIGDIR)" "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS) $(O)

# Fast HTML builder: https://sphinx.silverrainz.me/fasthtml/
.PHONY: fast
fast: Makefile
	@$(SPHINXBUILD) -b $@html -c "$(CONFIGDIR)" "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS) $(O)

# Snippet builder: https://sphinx.silverrainz.me/snippet/, for shell completion.
.PHONY: snip
snip: snippet

################################################################################
# View Helpers
################################################################################

.PHONY: view
view:
	xdg-open "$(BUILDDIR)/html/index.html"

.PHONY: serve
serve:
	cd utils && ./autobuild

################################################################################
# Git Helpers
################################################################################

.PHONY: status
status:
	@./utils/git-status

.PHONY: commit
commit:
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
	./utils/migrate-to-permnotes
