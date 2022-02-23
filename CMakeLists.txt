#
# CMakeLists.txt - cmake build file for cmake-demo
#

### BUILD SECTION ###
cmake_minimum_required(VERSION 3.0)

project(cmake-demo VERSION 0.0.1 LANGUAGES C)

# we always build shared libraries
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

set(MY_DEFAULT_LIB "lib")
if(CMAKE_INSTALL_LIBDIR AND NOT LIB_INSTALL_DIR)
	set(MY_DEFAULT_LIB "${CMAKE_INSTALL_LIBDIR}")
endif()
# this is overridden by RPM build on CentOS and Fedora
set(LIB_INSTALL_DIR "${MY_DEFAULT_LIB}" CACHE PATH "Default install dir for libraries.")
message("*** LIB_INSTALL_DIR='${LIB_INSTALL_DIR}'")

# simplified boilerplate from CMake presentation
set(default_build_type "Release")
if(NOT CMAKE_BUILD_TYPE)
  message(STATUS
  "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
      STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

add_library(demolib demolib.c)
set_property(TARGET demolib PROPERTY VERSION "0.0.1")
set_property(TARGET demolib PROPERTY SOVERSION "0")
# do not use RPATH - it is mostly bogus (pointing to BUILDROOT)
set(CMAKE_SKIP_BUILD_RPATH TRUE)

add_executable(demoapp demoapp.c)
target_link_libraries(demoapp PUBLIC demolib)

### INSTALL SECTION ###
install(TARGETS demoapp DESTINATION bin)
install(TARGETS demolib DESTINATION "${LIB_INSTALL_DIR}")

