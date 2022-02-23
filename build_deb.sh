#!/bin/bash

# direct build of Debian package
# install
#   sudo apt-get install devscripts cmake make gcc git

set -euo pipefail
set -x

cd $(dirname $0)
rm -f -- ../cmake-demo_* ../cmake-demo-dbgsym_*
# use "date -R" to get date for debian/changelog
# you may NOT add revision to   debian/changelog
# or you will get "native package version may not have a revision"
dpkg-parsechangelog
# build binary package
debuild -i -us -uc -b
# build source package
debuild -i -us -uc -S
exit 0

