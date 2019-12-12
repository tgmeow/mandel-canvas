# Mandelbrot unikernal service

This service listens on port 80 TCP for a MandelRequest and responds with a MandelResponse.   

It also uses the protobuf runtime library, therefore it can only be built if [IncludeOS](https://github.com/includeos/includeos) was installed with the `libprotobuf` option set to `ON`.


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

### Running in Google Cloud
https://www.includeos.org/blog/2017/includeos-on-google-compute-engine.html   
After building mandel_service...
```bash
boot -b -g mandel_service # attaches grub
mv mandel_service.grub.img disk.raw # Google Cloud expects a 'disk.raw' file
tar -zcf mandel_service.tar.gz disk.raw
```
Then upload this to a bucket in Google Cloud and then create an image from file in bucket.
