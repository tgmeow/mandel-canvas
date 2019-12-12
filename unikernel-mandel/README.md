### Mandelbrot unikernal service

This service is to test our build of the protobuf runtime library, therefore it can only be built if [IncludeOS](https://github.com/includeos/includeos) was installed with the `libprotobuf` option set to `ON`.


__Add the bincrafters remote__

For protobuf specifically, we use bincrafters conan package, thus you need to add the bincrafters remote to your remote list.

```
  $ conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
```

__Verify remotes:__

```
  $ conan remote list
  includeos: https://api.bintray.com/conan/includeos/includeos [Verify SSL: True]
  bincrafters: https://api.bintray.com/conan/bincrafters/public-conan [Verify SSL: True]
```  


### Build and run service

```bash
  mkdir build
  cd build
  conan install .. -pr clang-6.0-linux-x86_64
  source activate.sh
  cmake ..
  cmake --build .
  boot --create-bridge mandel_service
  source deactivate.sh
```
