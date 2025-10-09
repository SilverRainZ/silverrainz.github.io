confdir=$(git rev-parse --show-toplevel)
srcdir=$confdir/src
builddir=$confdir/build

mktmpdir() {
    mktemp -d /tmp/bullet-$(basename $0)-XXX
}
