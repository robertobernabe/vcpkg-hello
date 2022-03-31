cmake_minimum_required(VERSION 3.14)

if(NOT DEFINED VCPKG_ROOT)
  set(VCPKG_ROOT
      ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg
      CACHE PATH "Path to vcpkg directory")
endif()

# Copy the third party binaries to the install target
option(VCPKG_APPLOCAL_DEPS_INSTALL ON)
option(X_VCPKG_APPLOCAL_DEPS_INSTALL ON)

if(DEFINED VCPKG_ROOT)
  set(CMAKE_TOOLCHAIN_FILE
      "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      CACHE PATH "Path to vcpkg toolchain")
  if(NOT EXISTS "${CMAKE_TOOLCHAIN_FILE}")
    message(
      FATAL_ERROR
        "Invalid CMAKE_TOOLCHAIN_FILE specified (${CMAKE_TOOLCHAIN_FILE}, ${VCPKG_ROOT}); please specify an absolute path"
    )
  endif()
endif()

option(BUILD_TESTS "Build tests" OFF)
if(BUILD_TESTS)
  list(APPEND VCPKG_MANIFEST_FEATURES "tests")
endif()

project(vcpkg-hello VERSION 0.0.1)
include(GNUInstallDirs)
add_subdirectory(src)
