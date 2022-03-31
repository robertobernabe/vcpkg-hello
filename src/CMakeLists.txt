add_executable(vcpkg_hello main.cpp)

target_compile_features(vcpkg_hello PRIVATE cxx_std_17)
find_package(fmt REQUIRED)

target_link_libraries(vcpkg_hello PRIVATE fmt::fmt)
