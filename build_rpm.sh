#!/bin/bash

# direct build of RPM using tito

set -euo pipefail
set -x

cd $(dirname $0)
tito build --rpm --test

exit 0

