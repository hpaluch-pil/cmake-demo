# cmake-demo.spec for RedHat tito builder
Name:           cmake-demo
Version:        0.0.0
Release:        1
Summary:        cmake demo to test library and binary paths

Group:          Development/Tools
License:        MIT
URL:            https://github.com/hpaluch-pil/clockres
# NOTE: Must have .tar.gz suffix to work properly with Tito builder
Source0:        %{name}-%{version}.tar.gz
#BuildArch:      x86_64

BuildRequires:  gcc make
# NOTE: We can't test if 'cmake3' because it is defined even in Fedora 35!!
#       However '__cmake3' is defined under CentOS 7 only
%if %{defined __cmake3}
# on CentOS7 we have to use:
BuildRequires:  cmake3 cmake3-data
%else
BuildRequires:  cmake >= 3.0
%endif
%description
Trivial demo app and library to test cmake integration
with RPM tools

%prep
%setup -q 

%build
%if %{defined __cmake3}
# on CentOS7 we have to use:
%cmake3
%cmake3_build
%else
%cmake
%cmake_build
%endif

%install

%if %{defined __cmake3}
# on CentOS7 we have to use:
%cmake3_install
%else
%cmake_install
%endif

%files
%license LICENSE
%{_bindir}/demoapp
# always use _libdir to ensure that proper path is used
%{_libdir}

# use  date  '+%a %b %d %Y' to get date in format:
%changelog

