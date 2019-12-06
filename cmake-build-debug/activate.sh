OLD_PS1="$PS1"
export OLD_PS1
PS1="(conanenv) $PS1"
export PS1
CC="clang-6.0"
export CC
CXX="clang++-6.0"
export CXX
CFLAGS="-msse3 -mfpmath=sse -O2 -g"
export CFLAGS
CXXFLAGS="-msse3 -mfpmath=sse -O2 -g"
export CXXFLAGS
INCLUDEOS_VMRUNNER="/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9"
export INCLUDEOS_VMRUNNER
INCLUDEOS_CHAINLOADER="/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin"
export INCLUDEOS_CHAINLOADER
PROTOC_BIN="/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/bin/protoc"
export PROTOC_BIN
PATH="/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/x86_64-elf/bin":"/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/bin":"/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin":"/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin":"/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin":"/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/bin"${PATH+:$PATH}
export PATH
PYTHONPATH="/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9"${PYTHONPATH+:$PYTHONPATH}
export PYTHONPATH
