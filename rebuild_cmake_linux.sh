#!/bin/bash

# simple cmake build script

set -e
cd `dirname $0`
src="`pwd`"

build_type=''
WORKSPACE=''
tools_prefix=''
args=''

usage ()
{
	[ -z "$1" ] || echo "$1" >&2
	echo "Usage: $0 [ --ws WORKSPACE ] [ --build-type Debug | Release | MinSizeRel | RelWithDebInfo ]" >&2
	exit 1
}

while [ $# -gt 0 ]
do
	case "$1" in
		-h|--help)
			usage
			;;
		--ws)
			# WS is jenkins WORKSPACE for build
			WORKSPACE="$2"
			shift
			;;
		--build-type)
			case "$2" in
				Debug|Release|MinSizeRel|RelWithDebInfo)
					build_type="$2"
					shift
					;;
				*)
					usage "Invalid build type '$2'"
					;;
			esac
			;;
		*)
			usage "Invalid option \"$1\""
			;;
	esac
	shift
done

cmake_exe=cmake3 # CentOS 7
which $cmake_exe 2> /dev/null > /dev/null || cmake_exe=cmake # other systems

source /etc/os-release

p=cmake-demo-$ID-$VERSION_ID
[ -z "$build_type" ] || p="$p-$build_type"

[ -n "$WORKSPACE" ] || {
	# emulate jenkins workspace...
	WORKSPACE=~/tmp
}

[ -n "$WORKSPACE" -a -d "$WORKSPACE" ] || {
	echo "Internal error - $WORKSPACE is invalid" >&2
	exit 1
}

# always use hardcoded prefix to avoid disaster (rm -rf /) when variablei sempty
set -x
rm -rf $WORKSPACE/build/$p $WORKSPACE/install/$p
mkdir -p $WORKSPACE/build/$p $WORKSPACE/install/$p

cd $WORKSPACE/build/$p

[ -z "$build_type" ] || args="$args -DCMAKE_BUILD_TYPE=$build_type"

# generate Makefile under WORKSPACE
$cmake_exe $args $src
# build 
make VERBOSE=1

${tools_prefix}readelf -d libdemolib.so.[0-9]*.[0-9]*.[0-9]* |
       	grep -e '\(NAME\|SONAME\|NEEDED\|RUNPATH\)'
${tools_prefix}readelf -d demoapp | grep -e '\(NAME\|SONAME\|NEEDED\|RUNPATH\)'
make install DESTDIR=$WORKSPACE/install/$p
( cd $WORKSPACE/install/$p && find ./ )
exit 0

