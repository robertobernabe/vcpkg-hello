---
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
marp: true
footer: ''
---


![grayscale bg left](assets/florian_schaeffeler.jpg)



# Hi!

Florian Schäffeler :de::es:
:birthday: 38 years old
:computer: Software Developer, Build Engineer @ Avira (Now Part of NortonLifeLock)
:email: hello@fschaeffeler.de
:round_pushpin: Überlingen

Interests:
💻🥾🐶📖

:link: [robertobernabe/vcpkg-hello](https://github.com/robertobernabe/vcpkg-hello)


---

# **Vcpkg**

C/C++ dependency manager from Microsoft
For all platforms, buildsystems, and workflows

https://vcpkg.io/

---


- Cross platform C/C++ package manager
    - Windows, Linux, MacOs
- Round about 1900 available packages
- Package recipes based on CMake
- Integrates also in your IDE
   - Visual Studio
   - Visual Studio Code with CMake Tools
   - CLion
---

# Basic usage

```shell
git clone https://github.com/microsoft/vcpkg
cd vcpkg
bootstrap-vcpkg

```
```shell
vcpkg search fmt

fmt  8.1.1#1   Formatting library for C++. It can be used as a safe alternative to printf...

The result may be outdated. Run `git pull` to get the latest results.
```
---
# Install a package

```shell
vcpkg install fmt
```
```
Installing package fmt[core]:x64-linux...
...
...
Elapsed time for package fmt:x64-linux: 8.324 s

Total elapsed time: 15.6 s

The package fmt provides CMake targets:

    find_package(fmt CONFIG REQUIRED)
    target_link_libraries(main PRIVATE fmt::fmt)

```

---

# Behind the scenes

- Each package is defined as portfile in `vcpkg/ports/<portname>/portfile.cmake`
    - E.g. [vcpkg/ports/fmt/portfile.cmake](https://github.com/microsoft/vcpkg/blob/master/ports/fmt/portfile.cmake) 
- Each portfile is normally build up the same
    1. Download the sources
    2. Configure the build tool. E.g. cmake or even msbuild, bazel...
    3. Build the package from sources
    4. If build succeed, place 
      - the bin/lib in `vcpkg/installed/<arch>/bin` or `<arch>/lib`
      - place the headers in `<arch>/include` 

---

```cmake
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fmtlib/fmt
    REF 8.1.1
    SHA512 794a47d7cb352a2a9f2c050a60a46b002e4157e5ad23e15a5afc668e852b1e1847aeee3cda79e266c789ff79310d792060c94976ceef6352e322d60b94e23189
    HEAD_REF master
    PATCHES
        fix-write-batch.patch
        fix-invalid-command.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DFMT_CMAKE_DIR=share/fmt
        -DFMT_TEST=OFF
        -DFMT_DOC=OFF
)

```

---

# vcpkg/installed/<arch>
```
── debug
│   └── lib
│       ├── libfmtd.a
│      
│      
├── include
│   └── fmt
│       ├── ...
│       ├── format.h
├── lib
│   ├── libfmt.a
```
---

# Integrate vcpkg to your C/C++ project

- Place a `vcpkg.json` into your project root
```json
{
  "name": "vcpkg-hello",
  "version": "0.0.1",
  "dependencies": [
	"fmt"
  ]
}
```
- Run `vcpkg install` will find the dependencies specified in `vcpkg.json` and install them

---

# Integrate vcpkg to the build

- Vcpkg fits quite well in the cmake build process


```shell
# Configure it, will initiate also the vcpkg bootstrapping
cmake -B <build_dir> -S . -DCMAKE_TOOLCHAIN_FILE=<path to vcpkg>/scripts/buildsystems/vcpkg.cmake

# Build the actual project
cmake --build <build_dir>
```
- Using `vcpkg` as git submodule, you even don't have to pass `CMAKE_TOOLCHAIN_FILE` to the cmake invocation.

```cmake
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake
  CACHE STRING "Vcpkg toolchain file")
```

---

# Integrate vcpkg to the build


```cmake
project(vcpkg-hello VERSION 0.0.1)

add_executable(vcpkg_hello main.cpp)
find_package(fmt REQUIRED)
target_link_libraries(vcpkg_hello PRIVATE fmt::fmt)
```

```c++
#include <fmt/format.h>

int main() {
	fmt::print("Hello Vcpkg. Hello {}\n", "world");
}
```

---

# Questions ?

---

# Demo