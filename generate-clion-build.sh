#! /bin/bash
cd cmake-build-debug
conan install .. -pr clang-6.0-linux-x86_64
