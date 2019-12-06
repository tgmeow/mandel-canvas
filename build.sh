#! /bin/bash
cd build
conan install .. -pr clang-6.0-linux-x86_64
source activate.sh
cmake ..
cmake --build .
source deactivate.sh
