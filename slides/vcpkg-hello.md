---
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
marp: true
---


![bg left:40% 80%](assets/florian_schaeffeler.jpg)



# Hi!

Florian Schäffeler :de::es:
:birthday: 38 years old
:computer: Software Developer, Build Engineer @ Avira (Now Part of NortonLifeLock)
:round_pushpin: Überlingen

---

# **Vcpkg**

C/C++ dependency manager from Microsoft
For all platforms, buildsystems, and workflows

https://vcpkg.io/

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
# Integrate into your build
- Place an `vcpkg.json` into your project root
```json
{
  "name": "vcpkg-hello",
  "version": "0.0.1",
  "dependencies": [
	"fmt"
  ]
}
```
- Run `vcpkg install` will find dep specified in`vcpkg.json` and istall them
---
