srcdir=$(git rev-parse --show-toplevel)
builddir=$srcdir/_build

mktmpdir() {
    mktemp -d /tmp/bullet-$(basename $0)-XXX
}
