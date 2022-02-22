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
sudo yum install cmake3 make gcc
```


And build under `~/tmp`:
```bash
mkdir -p ~/tmp/
./rebuild_cmake_linux.sh
```





