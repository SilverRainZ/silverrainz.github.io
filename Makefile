# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -j auto
SPHINXBUILD   ?= python3 -msphinx
SPHINXSERV    ?= sphinx-autobuild
SPHINXINTL    ?= sphinx-intl
SOURCEDIR     = .
BUILDDIR      = _build
LOCALEDIR     = locale
LANG          = en_US.UTF-8
MAKE          = make

default: fast

view:
	xdg-open "$(BUILDDIR)/html/index.html"

serve:
	cd _utils && ./autobuild

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

migrate-to-permnotes:
	./_utils/migrate-to-permnotes

resume:
	cd _utils && ./singlepdf about/resume.rst

en:
	$(MAKE) gettext
	$(SPHINXINTL) update --pot-dir $(BUILDDIR)/gettext \
						 --locale-dir $(LOCALEDIR) \
						 --language $@ \
						 --jobs 1 # job=1 to prevent panic
	$(MAKE) html SPHINXOPTS=-Dlanguage=$@

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
