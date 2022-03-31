#!/usr/bin/env pwsh

Remove-Item ./build -Recurse -Force -ErrorAction Ignore

cmake -B build/ -S .
#cmake -B build/ -S . -DBUILD_TESTS=ON
if( !$? ) {
    Write-Error "Cmake configure failed"
    Exit 1
}
cmake --build build/
if( !$? ) {
    Write-Error "Cmake build failed"
    Exit 2
}