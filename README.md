# Cmake-demo

Simple demo library and demo app to be build with cmake. 
It will be used to test that library paths are correct
when building RPM and/or Debian package... TODO.

# Native build

cmake3 required. For Fedora 35:
```bash
sudo dnf install cmake make gcc
```

For CentOS 7:
- EPEL required

```bash
sudo yum install cmake3 cmake3-data make gcc
```

And build under `~/tmp`:
```bash
mkdir -p ~/tmp/
./rebuild_cmake_linux.sh
```

# RPM build with Tito

Tested under Fedora 35:

```bash
sudo dnf install tito gcc make rpm-build rpmdevtools
```

To build latest untagged version from git, use:
```bash
tito build --rpm --test
```

To build latest tagged version from git, use:
```bash
tito build --rpm
```

RPMS are created in folder `/tmp/tito` including `/tmp/tito/x86_64`.


# NOTES

Always validate spec file with:
```bash
rpmlint -i cmake-demo.spec
```



