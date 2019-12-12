#! /bin/bash
cd build
conan install .. -pr clang-6.0-linux-x86_64
source activate.sh
cmake .. -DCMAKE_CXX_COMPILER=clang-6.0 -DCMAKE_CC_COMPILER=clang-6.0
cmake --build .
source deactivate.sh
