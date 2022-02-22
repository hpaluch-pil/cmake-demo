# cmake-demo.spec for RedHat tito builder
Name:           cmake-demo
Version:        0.0.0
Release:        1
Summary:        cmake demo to test library and binary paths

Group:          Development Tools
License:        MIT
URL:            https://github.com/hpaluch-pil/clockres
# NOTE: Must have .tar.gz suffix to work properly with Tito builder
Source0:        %{name}-%{version}.tar.gz
#BuildArch:      x86_64

BuildRequires:  gcc make
BuildRequires:  cmake >= 3.0
# on CentOS7 we have to use:
#BuildRequires:  cmake3 cmake3-data
%description
Trivial demo app and library to test cmake integration
with RPM tools

%prep
%setup -q 

%build
%cmake
%cmake_build

%install

%cmake_install

%files
%license LICENSE
%{_bindir}/demoapp
# always use _libdir to ensure that proper path is used
%{_libdir}

# use  date  '+%a %b %d %Y' to get date in format:
%changelog

