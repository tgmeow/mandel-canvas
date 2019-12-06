include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
                set(CONAN_FRAMEWORKS ${CONAN_FRAMEWORKS_DEBUG} ${CONAN_FRAMEWORKS})
                set(CONAN_FRAMEWORK_DIRS ${CONAN_FRAMEWORK_DIRS_DEBUG} ${CONAN_FRAMEWORK_DIRS})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
                set(CONAN_FRAMEWORKS ${CONAN_FRAMEWORKS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
                set(CONAN_FRAMEWORK_DIRS ${CONAN_FRAMEWORK_DIRS_RELEASE} ${CONAN_FRAMEWORK_DIRS})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
                set(CONAN_FRAMEWORKS ${CONAN_FRAMEWORKS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
                set(CONAN_FRAMEWORK_DIRS ${CONAN_FRAMEWORK_DIRS_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
                set(CONAN_FRAMEWORKS ${CONAN_FRAMEWORKS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
                set(CONAN_FRAMEWORK_DIRS ${CONAN_FRAMEWORK_DIRS_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS})
            endif()
        endif()
        
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAME ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS})
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS}")
            endif()
        endforeach()
    endif()
endmacro()


set(CONAN_BINUTILS_ROOT "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6")
set(CONAN_INCLUDE_DIRS_BINUTILS )
set(CONAN_LIB_DIRS_BINUTILS "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/lib")
set(CONAN_BIN_DIRS_BINUTILS "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/bin")
set(CONAN_RES_DIRS_BINUTILS )
set(CONAN_SRC_DIRS_BINUTILS )
set(CONAN_BUILD_DIRS_BINUTILS "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/")
set(CONAN_FRAMEWORK_DIRS_BINUTILS )
set(CONAN_LIBS_BINUTILS )
set(CONAN_PKG_LIBS_BINUTILS )
set(CONAN_SYSTEM_LIBS_BINUTILS )
set(CONAN_FRAMEWORKS_BINUTILS )
set(CONAN_FRAMEWORKS_FOUND_BINUTILS "")  # Will be filled later
set(CONAN_DEFINES_BINUTILS )
set(CONAN_BUILD_MODULES_PATHS_BINUTILS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BINUTILS )

set(CONAN_C_FLAGS_BINUTILS "")
set(CONAN_CXX_FLAGS_BINUTILS "")
set(CONAN_SHARED_LINKER_FLAGS_BINUTILS "")
set(CONAN_EXE_LINKER_FLAGS_BINUTILS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BINUTILS_LIST "")
set(CONAN_CXX_FLAGS_BINUTILS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BINUTILS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BINUTILS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BINUTILS "${CONAN_FRAMEWORKS_BINUTILS}")
# Append to aggregated values variable
set(CONAN_LIBS_BINUTILS ${CONAN_PKG_LIBS_BINUTILS} ${CONAN_SYSTEM_LIBS_BINUTILS} ${CONAN_FRAMEWORKS_FOUND_BINUTILS})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_BINUTILS ${CONAN_PKG_LIBS_BINUTILS} ${CONAN_FRAMEWORKS_FOUND_BINUTILS})


set(CONAN_VMRUNNER_ROOT "/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_VMRUNNER )
set(CONAN_LIB_DIRS_VMRUNNER )
set(CONAN_BIN_DIRS_VMRUNNER "/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin")
set(CONAN_RES_DIRS_VMRUNNER )
set(CONAN_SRC_DIRS_VMRUNNER )
set(CONAN_BUILD_DIRS_VMRUNNER "/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_VMRUNNER )
set(CONAN_LIBS_VMRUNNER )
set(CONAN_PKG_LIBS_VMRUNNER )
set(CONAN_SYSTEM_LIBS_VMRUNNER )
set(CONAN_FRAMEWORKS_VMRUNNER )
set(CONAN_FRAMEWORKS_FOUND_VMRUNNER "")  # Will be filled later
set(CONAN_DEFINES_VMRUNNER )
set(CONAN_BUILD_MODULES_PATHS_VMRUNNER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VMRUNNER )

set(CONAN_C_FLAGS_VMRUNNER "")
set(CONAN_CXX_FLAGS_VMRUNNER "")
set(CONAN_SHARED_LINKER_FLAGS_VMRUNNER "")
set(CONAN_EXE_LINKER_FLAGS_VMRUNNER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VMRUNNER_LIST "")
set(CONAN_CXX_FLAGS_VMRUNNER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VMRUNNER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VMRUNNER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VMRUNNER "${CONAN_FRAMEWORKS_VMRUNNER}")
# Append to aggregated values variable
set(CONAN_LIBS_VMRUNNER ${CONAN_PKG_LIBS_VMRUNNER} ${CONAN_SYSTEM_LIBS_VMRUNNER} ${CONAN_FRAMEWORKS_FOUND_VMRUNNER})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_VMRUNNER ${CONAN_PKG_LIBS_VMRUNNER} ${CONAN_FRAMEWORKS_FOUND_VMRUNNER})


set(CONAN_VMBUILD_ROOT "/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830")
set(CONAN_INCLUDE_DIRS_VMBUILD )
set(CONAN_LIB_DIRS_VMBUILD )
set(CONAN_BIN_DIRS_VMBUILD "/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin")
set(CONAN_RES_DIRS_VMBUILD )
set(CONAN_SRC_DIRS_VMBUILD )
set(CONAN_BUILD_DIRS_VMBUILD "/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/")
set(CONAN_FRAMEWORK_DIRS_VMBUILD )
set(CONAN_LIBS_VMBUILD )
set(CONAN_PKG_LIBS_VMBUILD )
set(CONAN_SYSTEM_LIBS_VMBUILD )
set(CONAN_FRAMEWORKS_VMBUILD )
set(CONAN_FRAMEWORKS_FOUND_VMBUILD "")  # Will be filled later
set(CONAN_DEFINES_VMBUILD )
set(CONAN_BUILD_MODULES_PATHS_VMBUILD )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VMBUILD )

set(CONAN_C_FLAGS_VMBUILD "")
set(CONAN_CXX_FLAGS_VMBUILD "")
set(CONAN_SHARED_LINKER_FLAGS_VMBUILD "")
set(CONAN_EXE_LINKER_FLAGS_VMBUILD "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VMBUILD_LIST "")
set(CONAN_CXX_FLAGS_VMBUILD_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VMBUILD_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VMBUILD_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VMBUILD "${CONAN_FRAMEWORKS_VMBUILD}")
# Append to aggregated values variable
set(CONAN_LIBS_VMBUILD ${CONAN_PKG_LIBS_VMBUILD} ${CONAN_SYSTEM_LIBS_VMBUILD} ${CONAN_FRAMEWORKS_FOUND_VMBUILD})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_VMBUILD ${CONAN_PKG_LIBS_VMBUILD} ${CONAN_FRAMEWORKS_FOUND_VMBUILD})


set(CONAN_CHAINLOADER_ROOT "/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_CHAINLOADER )
set(CONAN_LIB_DIRS_CHAINLOADER )
set(CONAN_BIN_DIRS_CHAINLOADER "/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin")
set(CONAN_RES_DIRS_CHAINLOADER )
set(CONAN_SRC_DIRS_CHAINLOADER )
set(CONAN_BUILD_DIRS_CHAINLOADER "/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_CHAINLOADER )
set(CONAN_LIBS_CHAINLOADER )
set(CONAN_PKG_LIBS_CHAINLOADER )
set(CONAN_SYSTEM_LIBS_CHAINLOADER )
set(CONAN_FRAMEWORKS_CHAINLOADER )
set(CONAN_FRAMEWORKS_FOUND_CHAINLOADER "")  # Will be filled later
set(CONAN_DEFINES_CHAINLOADER )
set(CONAN_BUILD_MODULES_PATHS_CHAINLOADER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_CHAINLOADER )

set(CONAN_C_FLAGS_CHAINLOADER "")
set(CONAN_CXX_FLAGS_CHAINLOADER "")
set(CONAN_SHARED_LINKER_FLAGS_CHAINLOADER "")
set(CONAN_EXE_LINKER_FLAGS_CHAINLOADER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_CHAINLOADER_LIST "")
set(CONAN_CXX_FLAGS_CHAINLOADER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_CHAINLOADER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_CHAINLOADER "${CONAN_FRAMEWORKS_CHAINLOADER}")
# Append to aggregated values variable
set(CONAN_LIBS_CHAINLOADER ${CONAN_PKG_LIBS_CHAINLOADER} ${CONAN_SYSTEM_LIBS_CHAINLOADER} ${CONAN_FRAMEWORKS_FOUND_CHAINLOADER})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_CHAINLOADER ${CONAN_PKG_LIBS_CHAINLOADER} ${CONAN_FRAMEWORKS_FOUND_CHAINLOADER})


set(CONAN_DISKBUILDER_ROOT "/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830")
set(CONAN_INCLUDE_DIRS_DISKBUILDER )
set(CONAN_LIB_DIRS_DISKBUILDER )
set(CONAN_BIN_DIRS_DISKBUILDER "/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin")
set(CONAN_RES_DIRS_DISKBUILDER )
set(CONAN_SRC_DIRS_DISKBUILDER )
set(CONAN_BUILD_DIRS_DISKBUILDER "/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/")
set(CONAN_FRAMEWORK_DIRS_DISKBUILDER )
set(CONAN_LIBS_DISKBUILDER )
set(CONAN_PKG_LIBS_DISKBUILDER )
set(CONAN_SYSTEM_LIBS_DISKBUILDER )
set(CONAN_FRAMEWORKS_DISKBUILDER )
set(CONAN_FRAMEWORKS_FOUND_DISKBUILDER "")  # Will be filled later
set(CONAN_DEFINES_DISKBUILDER )
set(CONAN_BUILD_MODULES_PATHS_DISKBUILDER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_DISKBUILDER )

set(CONAN_C_FLAGS_DISKBUILDER "")
set(CONAN_CXX_FLAGS_DISKBUILDER "")
set(CONAN_SHARED_LINKER_FLAGS_DISKBUILDER "")
set(CONAN_EXE_LINKER_FLAGS_DISKBUILDER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_DISKBUILDER_LIST "")
set(CONAN_CXX_FLAGS_DISKBUILDER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_DISKBUILDER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_DISKBUILDER "${CONAN_FRAMEWORKS_DISKBUILDER}")
# Append to aggregated values variable
set(CONAN_LIBS_DISKBUILDER ${CONAN_PKG_LIBS_DISKBUILDER} ${CONAN_SYSTEM_LIBS_DISKBUILDER} ${CONAN_FRAMEWORKS_FOUND_DISKBUILDER})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_DISKBUILDER ${CONAN_PKG_LIBS_DISKBUILDER} ${CONAN_FRAMEWORKS_FOUND_DISKBUILDER})


set(CONAN_PROTOC_INSTALLER_ROOT "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a")
set(CONAN_INCLUDE_DIRS_PROTOC_INSTALLER "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/include")
set(CONAN_LIB_DIRS_PROTOC_INSTALLER "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/lib")
set(CONAN_BIN_DIRS_PROTOC_INSTALLER "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/bin")
set(CONAN_RES_DIRS_PROTOC_INSTALLER )
set(CONAN_SRC_DIRS_PROTOC_INSTALLER )
set(CONAN_BUILD_DIRS_PROTOC_INSTALLER "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/")
set(CONAN_FRAMEWORK_DIRS_PROTOC_INSTALLER )
set(CONAN_LIBS_PROTOC_INSTALLER )
set(CONAN_PKG_LIBS_PROTOC_INSTALLER )
set(CONAN_SYSTEM_LIBS_PROTOC_INSTALLER )
set(CONAN_FRAMEWORKS_PROTOC_INSTALLER )
set(CONAN_FRAMEWORKS_FOUND_PROTOC_INSTALLER "")  # Will be filled later
set(CONAN_DEFINES_PROTOC_INSTALLER )
set(CONAN_BUILD_MODULES_PATHS_PROTOC_INSTALLER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER )

set(CONAN_C_FLAGS_PROTOC_INSTALLER "")
set(CONAN_CXX_FLAGS_PROTOC_INSTALLER "")
set(CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER "")
set(CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_PROTOC_INSTALLER_LIST "")
set(CONAN_CXX_FLAGS_PROTOC_INSTALLER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_PROTOC_INSTALLER "${CONAN_FRAMEWORKS_PROTOC_INSTALLER}")
# Append to aggregated values variable
set(CONAN_LIBS_PROTOC_INSTALLER ${CONAN_PKG_LIBS_PROTOC_INSTALLER} ${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER} ${CONAN_FRAMEWORKS_FOUND_PROTOC_INSTALLER})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER ${CONAN_PKG_LIBS_PROTOC_INSTALLER} ${CONAN_FRAMEWORKS_FOUND_PROTOC_INSTALLER})


set(CONAN_INCLUDEOS_ROOT "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2")
set(CONAN_INCLUDE_DIRS_INCLUDEOS "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/include/os")
set(CONAN_LIB_DIRS_INCLUDEOS "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/lib"
			"/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/platform")
set(CONAN_BIN_DIRS_INCLUDEOS )
set(CONAN_RES_DIRS_INCLUDEOS "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2")
set(CONAN_SRC_DIRS_INCLUDEOS )
set(CONAN_BUILD_DIRS_INCLUDEOS "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/cmake")
set(CONAN_FRAMEWORK_DIRS_INCLUDEOS )
set(CONAN_LIBS_INCLUDEOS os arch musl_syscalls x86_64_pc)
set(CONAN_PKG_LIBS_INCLUDEOS os arch musl_syscalls x86_64_pc)
set(CONAN_SYSTEM_LIBS_INCLUDEOS )
set(CONAN_FRAMEWORKS_INCLUDEOS )
set(CONAN_FRAMEWORKS_FOUND_INCLUDEOS "")  # Will be filled later
set(CONAN_DEFINES_INCLUDEOS )
set(CONAN_BUILD_MODULES_PATHS_INCLUDEOS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_INCLUDEOS )

set(CONAN_C_FLAGS_INCLUDEOS "")
set(CONAN_CXX_FLAGS_INCLUDEOS "")
set(CONAN_SHARED_LINKER_FLAGS_INCLUDEOS "")
set(CONAN_EXE_LINKER_FLAGS_INCLUDEOS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_INCLUDEOS_LIST "")
set(CONAN_CXX_FLAGS_INCLUDEOS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_INCLUDEOS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_INCLUDEOS "${CONAN_FRAMEWORKS_INCLUDEOS}")
# Append to aggregated values variable
set(CONAN_LIBS_INCLUDEOS ${CONAN_PKG_LIBS_INCLUDEOS} ${CONAN_SYSTEM_LIBS_INCLUDEOS} ${CONAN_FRAMEWORKS_FOUND_INCLUDEOS})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_INCLUDEOS ${CONAN_PKG_LIBS_INCLUDEOS} ${CONAN_FRAMEWORKS_FOUND_INCLUDEOS})


set(CONAN_PROTOBUF_ROOT "/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d")
set(CONAN_INCLUDE_DIRS_PROTOBUF "/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/include")
set(CONAN_LIB_DIRS_PROTOBUF "/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/lib")
set(CONAN_BIN_DIRS_PROTOBUF )
set(CONAN_RES_DIRS_PROTOBUF )
set(CONAN_SRC_DIRS_PROTOBUF )
set(CONAN_BUILD_DIRS_PROTOBUF "/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/")
set(CONAN_FRAMEWORK_DIRS_PROTOBUF )
set(CONAN_LIBS_PROTOBUF protoc protobuf pthread)
set(CONAN_PKG_LIBS_PROTOBUF protoc protobuf pthread)
set(CONAN_SYSTEM_LIBS_PROTOBUF )
set(CONAN_FRAMEWORKS_PROTOBUF )
set(CONAN_FRAMEWORKS_FOUND_PROTOBUF "")  # Will be filled later
set(CONAN_DEFINES_PROTOBUF )
set(CONAN_BUILD_MODULES_PATHS_PROTOBUF )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_PROTOBUF )

set(CONAN_C_FLAGS_PROTOBUF "")
set(CONAN_CXX_FLAGS_PROTOBUF "")
set(CONAN_SHARED_LINKER_FLAGS_PROTOBUF "")
set(CONAN_EXE_LINKER_FLAGS_PROTOBUF "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_PROTOBUF_LIST "")
set(CONAN_CXX_FLAGS_PROTOBUF_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_PROTOBUF_LIST "")
set(CONAN_EXE_LINKER_FLAGS_PROTOBUF_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_PROTOBUF "${CONAN_FRAMEWORKS_PROTOBUF}")
# Append to aggregated values variable
set(CONAN_LIBS_PROTOBUF ${CONAN_PKG_LIBS_PROTOBUF} ${CONAN_SYSTEM_LIBS_PROTOBUF} ${CONAN_FRAMEWORKS_FOUND_PROTOBUF})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_PROTOBUF ${CONAN_PKG_LIBS_PROTOBUF} ${CONAN_FRAMEWORKS_FOUND_PROTOBUF})


set(CONAN_GSL_ROOT "/home/vagrant/.conan/data/GSL/2.0.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_GSL "/home/vagrant/.conan/data/GSL/2.0.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_GSL )
set(CONAN_BIN_DIRS_GSL )
set(CONAN_RES_DIRS_GSL )
set(CONAN_SRC_DIRS_GSL )
set(CONAN_BUILD_DIRS_GSL "/home/vagrant/.conan/data/GSL/2.0.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_GSL )
set(CONAN_LIBS_GSL )
set(CONAN_PKG_LIBS_GSL )
set(CONAN_SYSTEM_LIBS_GSL )
set(CONAN_FRAMEWORKS_GSL )
set(CONAN_FRAMEWORKS_FOUND_GSL "")  # Will be filled later
set(CONAN_DEFINES_GSL )
set(CONAN_BUILD_MODULES_PATHS_GSL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GSL )

set(CONAN_C_FLAGS_GSL "")
set(CONAN_CXX_FLAGS_GSL "")
set(CONAN_SHARED_LINKER_FLAGS_GSL "")
set(CONAN_EXE_LINKER_FLAGS_GSL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GSL_LIST "")
set(CONAN_CXX_FLAGS_GSL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GSL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GSL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GSL "${CONAN_FRAMEWORKS_GSL}")
# Append to aggregated values variable
set(CONAN_LIBS_GSL ${CONAN_PKG_LIBS_GSL} ${CONAN_SYSTEM_LIBS_GSL} ${CONAN_FRAMEWORKS_FOUND_GSL})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_GSL ${CONAN_PKG_LIBS_GSL} ${CONAN_FRAMEWORKS_FOUND_GSL})


set(CONAN_LIBGCC_ROOT "/home/vagrant/.conan/data/libgcc/1.0/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f")
set(CONAN_INCLUDE_DIRS_LIBGCC )
set(CONAN_LIB_DIRS_LIBGCC "/home/vagrant/.conan/data/libgcc/1.0/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/lib")
set(CONAN_BIN_DIRS_LIBGCC )
set(CONAN_RES_DIRS_LIBGCC )
set(CONAN_SRC_DIRS_LIBGCC )
set(CONAN_BUILD_DIRS_LIBGCC "/home/vagrant/.conan/data/libgcc/1.0/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/")
set(CONAN_FRAMEWORK_DIRS_LIBGCC )
set(CONAN_LIBS_LIBGCC compiler)
set(CONAN_PKG_LIBS_LIBGCC compiler)
set(CONAN_SYSTEM_LIBS_LIBGCC )
set(CONAN_FRAMEWORKS_LIBGCC )
set(CONAN_FRAMEWORKS_FOUND_LIBGCC "")  # Will be filled later
set(CONAN_DEFINES_LIBGCC )
set(CONAN_BUILD_MODULES_PATHS_LIBGCC )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBGCC )

set(CONAN_C_FLAGS_LIBGCC "")
set(CONAN_CXX_FLAGS_LIBGCC "")
set(CONAN_SHARED_LINKER_FLAGS_LIBGCC "")
set(CONAN_EXE_LINKER_FLAGS_LIBGCC "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBGCC_LIST "")
set(CONAN_CXX_FLAGS_LIBGCC_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBGCC_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBGCC_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBGCC "${CONAN_FRAMEWORKS_LIBGCC}")
# Append to aggregated values variable
set(CONAN_LIBS_LIBGCC ${CONAN_PKG_LIBS_LIBGCC} ${CONAN_SYSTEM_LIBS_LIBGCC} ${CONAN_FRAMEWORKS_FOUND_LIBGCC})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_LIBGCC ${CONAN_PKG_LIBS_LIBGCC} ${CONAN_FRAMEWORKS_FOUND_LIBGCC})


set(CONAN_RAPIDJSON_ROOT "/home/vagrant/.conan/data/rapidjson/1.1.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_RAPIDJSON "/home/vagrant/.conan/data/rapidjson/1.1.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_RAPIDJSON )
set(CONAN_BIN_DIRS_RAPIDJSON )
set(CONAN_RES_DIRS_RAPIDJSON )
set(CONAN_SRC_DIRS_RAPIDJSON )
set(CONAN_BUILD_DIRS_RAPIDJSON "/home/vagrant/.conan/data/rapidjson/1.1.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_RAPIDJSON )
set(CONAN_LIBS_RAPIDJSON )
set(CONAN_PKG_LIBS_RAPIDJSON )
set(CONAN_SYSTEM_LIBS_RAPIDJSON )
set(CONAN_FRAMEWORKS_RAPIDJSON )
set(CONAN_FRAMEWORKS_FOUND_RAPIDJSON "")  # Will be filled later
set(CONAN_DEFINES_RAPIDJSON )
set(CONAN_BUILD_MODULES_PATHS_RAPIDJSON )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_RAPIDJSON )

set(CONAN_C_FLAGS_RAPIDJSON "")
set(CONAN_CXX_FLAGS_RAPIDJSON "")
set(CONAN_SHARED_LINKER_FLAGS_RAPIDJSON "")
set(CONAN_EXE_LINKER_FLAGS_RAPIDJSON "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_RAPIDJSON_LIST "")
set(CONAN_CXX_FLAGS_RAPIDJSON_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_LIST "")
set(CONAN_EXE_LINKER_FLAGS_RAPIDJSON_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_RAPIDJSON "${CONAN_FRAMEWORKS_RAPIDJSON}")
# Append to aggregated values variable
set(CONAN_LIBS_RAPIDJSON ${CONAN_PKG_LIBS_RAPIDJSON} ${CONAN_SYSTEM_LIBS_RAPIDJSON} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_RAPIDJSON ${CONAN_PKG_LIBS_RAPIDJSON} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON})


set(CONAN_HTTP-PARSER_ROOT "/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab")
set(CONAN_INCLUDE_DIRS_HTTP-PARSER "/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include")
set(CONAN_LIB_DIRS_HTTP-PARSER "/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib")
set(CONAN_BIN_DIRS_HTTP-PARSER )
set(CONAN_RES_DIRS_HTTP-PARSER )
set(CONAN_SRC_DIRS_HTTP-PARSER )
set(CONAN_BUILD_DIRS_HTTP-PARSER "/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/")
set(CONAN_FRAMEWORK_DIRS_HTTP-PARSER )
set(CONAN_LIBS_HTTP-PARSER http-parser)
set(CONAN_PKG_LIBS_HTTP-PARSER http-parser)
set(CONAN_SYSTEM_LIBS_HTTP-PARSER )
set(CONAN_FRAMEWORKS_HTTP-PARSER )
set(CONAN_FRAMEWORKS_FOUND_HTTP-PARSER "")  # Will be filled later
set(CONAN_DEFINES_HTTP-PARSER )
set(CONAN_BUILD_MODULES_PATHS_HTTP-PARSER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_HTTP-PARSER )

set(CONAN_C_FLAGS_HTTP-PARSER "")
set(CONAN_CXX_FLAGS_HTTP-PARSER "")
set(CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER "")
set(CONAN_EXE_LINKER_FLAGS_HTTP-PARSER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_HTTP-PARSER_LIST "")
set(CONAN_CXX_FLAGS_HTTP-PARSER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_HTTP-PARSER "${CONAN_FRAMEWORKS_HTTP-PARSER}")
# Append to aggregated values variable
set(CONAN_LIBS_HTTP-PARSER ${CONAN_PKG_LIBS_HTTP-PARSER} ${CONAN_SYSTEM_LIBS_HTTP-PARSER} ${CONAN_FRAMEWORKS_FOUND_HTTP-PARSER})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_HTTP-PARSER ${CONAN_PKG_LIBS_HTTP-PARSER} ${CONAN_FRAMEWORKS_FOUND_HTTP-PARSER})


set(CONAN_UZLIB_ROOT "/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab")
set(CONAN_INCLUDE_DIRS_UZLIB "/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include")
set(CONAN_LIB_DIRS_UZLIB "/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib")
set(CONAN_BIN_DIRS_UZLIB )
set(CONAN_RES_DIRS_UZLIB )
set(CONAN_SRC_DIRS_UZLIB )
set(CONAN_BUILD_DIRS_UZLIB "/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/")
set(CONAN_FRAMEWORK_DIRS_UZLIB )
set(CONAN_LIBS_UZLIB tinf)
set(CONAN_PKG_LIBS_UZLIB tinf)
set(CONAN_SYSTEM_LIBS_UZLIB )
set(CONAN_FRAMEWORKS_UZLIB )
set(CONAN_FRAMEWORKS_FOUND_UZLIB "")  # Will be filled later
set(CONAN_DEFINES_UZLIB )
set(CONAN_BUILD_MODULES_PATHS_UZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_UZLIB )

set(CONAN_C_FLAGS_UZLIB "")
set(CONAN_CXX_FLAGS_UZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_UZLIB "")
set(CONAN_EXE_LINKER_FLAGS_UZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_UZLIB_LIST "")
set(CONAN_CXX_FLAGS_UZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_UZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_UZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_UZLIB "${CONAN_FRAMEWORKS_UZLIB}")
# Append to aggregated values variable
set(CONAN_LIBS_UZLIB ${CONAN_PKG_LIBS_UZLIB} ${CONAN_SYSTEM_LIBS_UZLIB} ${CONAN_FRAMEWORKS_FOUND_UZLIB})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_UZLIB ${CONAN_PKG_LIBS_UZLIB} ${CONAN_FRAMEWORKS_FOUND_UZLIB})


set(CONAN_BOTAN_ROOT "/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f")
set(CONAN_INCLUDE_DIRS_BOTAN "/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/include")
set(CONAN_LIB_DIRS_BOTAN "/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/lib")
set(CONAN_BIN_DIRS_BOTAN )
set(CONAN_RES_DIRS_BOTAN )
set(CONAN_SRC_DIRS_BOTAN )
set(CONAN_BUILD_DIRS_BOTAN "/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/")
set(CONAN_FRAMEWORK_DIRS_BOTAN )
set(CONAN_LIBS_BOTAN )
set(CONAN_PKG_LIBS_BOTAN )
set(CONAN_SYSTEM_LIBS_BOTAN )
set(CONAN_FRAMEWORKS_BOTAN )
set(CONAN_FRAMEWORKS_FOUND_BOTAN "")  # Will be filled later
set(CONAN_DEFINES_BOTAN )
set(CONAN_BUILD_MODULES_PATHS_BOTAN )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BOTAN )

set(CONAN_C_FLAGS_BOTAN "")
set(CONAN_CXX_FLAGS_BOTAN "")
set(CONAN_SHARED_LINKER_FLAGS_BOTAN "")
set(CONAN_EXE_LINKER_FLAGS_BOTAN "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BOTAN_LIST "")
set(CONAN_CXX_FLAGS_BOTAN_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BOTAN_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BOTAN_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BOTAN "${CONAN_FRAMEWORKS_BOTAN}")
# Append to aggregated values variable
set(CONAN_LIBS_BOTAN ${CONAN_PKG_LIBS_BOTAN} ${CONAN_SYSTEM_LIBS_BOTAN} ${CONAN_FRAMEWORKS_FOUND_BOTAN})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_BOTAN ${CONAN_PKG_LIBS_BOTAN} ${CONAN_FRAMEWORKS_FOUND_BOTAN})


set(CONAN_S2N_ROOT "/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5")
set(CONAN_INCLUDE_DIRS_S2N "/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/include")
set(CONAN_LIB_DIRS_S2N "/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/lib")
set(CONAN_BIN_DIRS_S2N )
set(CONAN_RES_DIRS_S2N )
set(CONAN_SRC_DIRS_S2N )
set(CONAN_BUILD_DIRS_S2N "/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/")
set(CONAN_FRAMEWORK_DIRS_S2N )
set(CONAN_LIBS_S2N s2n)
set(CONAN_PKG_LIBS_S2N s2n)
set(CONAN_SYSTEM_LIBS_S2N )
set(CONAN_FRAMEWORKS_S2N )
set(CONAN_FRAMEWORKS_FOUND_S2N "")  # Will be filled later
set(CONAN_DEFINES_S2N )
set(CONAN_BUILD_MODULES_PATHS_S2N )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_S2N )

set(CONAN_C_FLAGS_S2N "")
set(CONAN_CXX_FLAGS_S2N "")
set(CONAN_SHARED_LINKER_FLAGS_S2N "")
set(CONAN_EXE_LINKER_FLAGS_S2N "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_S2N_LIST "")
set(CONAN_CXX_FLAGS_S2N_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_S2N_LIST "")
set(CONAN_EXE_LINKER_FLAGS_S2N_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_S2N "${CONAN_FRAMEWORKS_S2N}")
# Append to aggregated values variable
set(CONAN_LIBS_S2N ${CONAN_PKG_LIBS_S2N} ${CONAN_SYSTEM_LIBS_S2N} ${CONAN_FRAMEWORKS_FOUND_S2N})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_S2N ${CONAN_PKG_LIBS_S2N} ${CONAN_FRAMEWORKS_FOUND_S2N})


set(CONAN_OPENSSL_ROOT "/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9")
set(CONAN_INCLUDE_DIRS_OPENSSL "/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/include")
set(CONAN_LIB_DIRS_OPENSSL "/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/lib")
set(CONAN_BIN_DIRS_OPENSSL )
set(CONAN_RES_DIRS_OPENSSL )
set(CONAN_SRC_DIRS_OPENSSL )
set(CONAN_BUILD_DIRS_OPENSSL "/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/")
set(CONAN_FRAMEWORK_DIRS_OPENSSL )
set(CONAN_LIBS_OPENSSL crypto ssl)
set(CONAN_PKG_LIBS_OPENSSL crypto ssl)
set(CONAN_SYSTEM_LIBS_OPENSSL )
set(CONAN_FRAMEWORKS_OPENSSL )
set(CONAN_FRAMEWORKS_FOUND_OPENSSL "")  # Will be filled later
set(CONAN_DEFINES_OPENSSL )
set(CONAN_BUILD_MODULES_PATHS_OPENSSL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENSSL )

set(CONAN_C_FLAGS_OPENSSL "")
set(CONAN_CXX_FLAGS_OPENSSL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENSSL_LIST "")
set(CONAN_CXX_FLAGS_OPENSSL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENSSL "${CONAN_FRAMEWORKS_OPENSSL}")
# Append to aggregated values variable
set(CONAN_LIBS_OPENSSL ${CONAN_PKG_LIBS_OPENSSL} ${CONAN_SYSTEM_LIBS_OPENSSL} ${CONAN_FRAMEWORKS_FOUND_OPENSSL})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_OPENSSL ${CONAN_PKG_LIBS_OPENSSL} ${CONAN_FRAMEWORKS_FOUND_OPENSSL})


set(CONAN_LIBCXX_ROOT "/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012")
set(CONAN_INCLUDE_DIRS_LIBCXX "/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/include"
			"/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/include/c++/v1")
set(CONAN_LIB_DIRS_LIBCXX "/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/lib")
set(CONAN_BIN_DIRS_LIBCXX )
set(CONAN_RES_DIRS_LIBCXX )
set(CONAN_SRC_DIRS_LIBCXX )
set(CONAN_BUILD_DIRS_LIBCXX "/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/")
set(CONAN_FRAMEWORK_DIRS_LIBCXX )
set(CONAN_LIBS_LIBCXX c++ c++experimental)
set(CONAN_PKG_LIBS_LIBCXX c++ c++experimental)
set(CONAN_SYSTEM_LIBS_LIBCXX )
set(CONAN_FRAMEWORKS_LIBCXX )
set(CONAN_FRAMEWORKS_FOUND_LIBCXX "")  # Will be filled later
set(CONAN_DEFINES_LIBCXX )
set(CONAN_BUILD_MODULES_PATHS_LIBCXX )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBCXX )

set(CONAN_C_FLAGS_LIBCXX "")
set(CONAN_CXX_FLAGS_LIBCXX "")
set(CONAN_SHARED_LINKER_FLAGS_LIBCXX "")
set(CONAN_EXE_LINKER_FLAGS_LIBCXX "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBCXX_LIST "")
set(CONAN_CXX_FLAGS_LIBCXX_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBCXX_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBCXX_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBCXX "${CONAN_FRAMEWORKS_LIBCXX}")
# Append to aggregated values variable
set(CONAN_LIBS_LIBCXX ${CONAN_PKG_LIBS_LIBCXX} ${CONAN_SYSTEM_LIBS_LIBCXX} ${CONAN_FRAMEWORKS_FOUND_LIBCXX})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_LIBCXX ${CONAN_PKG_LIBS_LIBCXX} ${CONAN_FRAMEWORKS_FOUND_LIBCXX})


set(CONAN_MUSL_ROOT "/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43")
set(CONAN_INCLUDE_DIRS_MUSL "/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/include")
set(CONAN_LIB_DIRS_MUSL "/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/lib")
set(CONAN_BIN_DIRS_MUSL )
set(CONAN_RES_DIRS_MUSL )
set(CONAN_SRC_DIRS_MUSL )
set(CONAN_BUILD_DIRS_MUSL "/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/")
set(CONAN_FRAMEWORK_DIRS_MUSL )
set(CONAN_LIBS_MUSL c crypt m rt dl pthread resolv util xnet)
set(CONAN_PKG_LIBS_MUSL c crypt m rt dl pthread resolv util xnet)
set(CONAN_SYSTEM_LIBS_MUSL )
set(CONAN_FRAMEWORKS_MUSL )
set(CONAN_FRAMEWORKS_FOUND_MUSL "")  # Will be filled later
set(CONAN_DEFINES_MUSL )
set(CONAN_BUILD_MODULES_PATHS_MUSL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_MUSL )

set(CONAN_C_FLAGS_MUSL "")
set(CONAN_CXX_FLAGS_MUSL "")
set(CONAN_SHARED_LINKER_FLAGS_MUSL "")
set(CONAN_EXE_LINKER_FLAGS_MUSL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_MUSL_LIST "")
set(CONAN_CXX_FLAGS_MUSL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_MUSL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_MUSL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_MUSL "${CONAN_FRAMEWORKS_MUSL}")
# Append to aggregated values variable
set(CONAN_LIBS_MUSL ${CONAN_PKG_LIBS_MUSL} ${CONAN_SYSTEM_LIBS_MUSL} ${CONAN_FRAMEWORKS_FOUND_MUSL})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_MUSL ${CONAN_PKG_LIBS_MUSL} ${CONAN_FRAMEWORKS_FOUND_MUSL})


set(CONAN_LIBUNWIND_ROOT "/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab")
set(CONAN_INCLUDE_DIRS_LIBUNWIND "/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include")
set(CONAN_LIB_DIRS_LIBUNWIND "/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib")
set(CONAN_BIN_DIRS_LIBUNWIND )
set(CONAN_RES_DIRS_LIBUNWIND )
set(CONAN_SRC_DIRS_LIBUNWIND )
set(CONAN_BUILD_DIRS_LIBUNWIND "/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/")
set(CONAN_FRAMEWORK_DIRS_LIBUNWIND )
set(CONAN_LIBS_LIBUNWIND unwind)
set(CONAN_PKG_LIBS_LIBUNWIND unwind)
set(CONAN_SYSTEM_LIBS_LIBUNWIND )
set(CONAN_FRAMEWORKS_LIBUNWIND )
set(CONAN_FRAMEWORKS_FOUND_LIBUNWIND "")  # Will be filled later
set(CONAN_DEFINES_LIBUNWIND )
set(CONAN_BUILD_MODULES_PATHS_LIBUNWIND )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBUNWIND )

set(CONAN_C_FLAGS_LIBUNWIND "")
set(CONAN_CXX_FLAGS_LIBUNWIND "")
set(CONAN_SHARED_LINKER_FLAGS_LIBUNWIND "")
set(CONAN_EXE_LINKER_FLAGS_LIBUNWIND "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBUNWIND_LIST "")
set(CONAN_CXX_FLAGS_LIBUNWIND_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBUNWIND_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBUNWIND "${CONAN_FRAMEWORKS_LIBUNWIND}")
# Append to aggregated values variable
set(CONAN_LIBS_LIBUNWIND ${CONAN_PKG_LIBS_LIBUNWIND} ${CONAN_SYSTEM_LIBS_LIBUNWIND} ${CONAN_FRAMEWORKS_FOUND_LIBUNWIND})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_LIBUNWIND ${CONAN_PKG_LIBS_LIBUNWIND} ${CONAN_FRAMEWORKS_FOUND_LIBUNWIND})


set(CONAN_LIBCXXABI_ROOT "/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f")
set(CONAN_INCLUDE_DIRS_LIBCXXABI "/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/include")
set(CONAN_LIB_DIRS_LIBCXXABI "/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/lib")
set(CONAN_BIN_DIRS_LIBCXXABI )
set(CONAN_RES_DIRS_LIBCXXABI )
set(CONAN_SRC_DIRS_LIBCXXABI )
set(CONAN_BUILD_DIRS_LIBCXXABI "/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/")
set(CONAN_FRAMEWORK_DIRS_LIBCXXABI )
set(CONAN_LIBS_LIBCXXABI c++abi)
set(CONAN_PKG_LIBS_LIBCXXABI c++abi)
set(CONAN_SYSTEM_LIBS_LIBCXXABI )
set(CONAN_FRAMEWORKS_LIBCXXABI )
set(CONAN_FRAMEWORKS_FOUND_LIBCXXABI "")  # Will be filled later
set(CONAN_DEFINES_LIBCXXABI )
set(CONAN_BUILD_MODULES_PATHS_LIBCXXABI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBCXXABI )

set(CONAN_C_FLAGS_LIBCXXABI "")
set(CONAN_CXX_FLAGS_LIBCXXABI "")
set(CONAN_SHARED_LINKER_FLAGS_LIBCXXABI "")
set(CONAN_EXE_LINKER_FLAGS_LIBCXXABI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBCXXABI_LIST "")
set(CONAN_CXX_FLAGS_LIBCXXABI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBCXXABI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBCXXABI "${CONAN_FRAMEWORKS_LIBCXXABI}")
# Append to aggregated values variable
set(CONAN_LIBS_LIBCXXABI ${CONAN_PKG_LIBS_LIBCXXABI} ${CONAN_SYSTEM_LIBS_LIBCXXABI} ${CONAN_FRAMEWORKS_FOUND_LIBCXXABI})
# Aggregate package libs and frameworks for conan_package_library_targets()
set(CONAN_LIBS_FRAMEWORKS_LIBCXXABI ${CONAN_PKG_LIBS_LIBCXXABI} ${CONAN_FRAMEWORKS_FOUND_LIBCXXABI})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "x86_64")
set(CONAN_SETTINGS_ARCH_BUILD "x86_64")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "clang")
set(CONAN_SETTINGS_COMPILER_LIBCXX "libc++")
set(CONAN_SETTINGS_COMPILER_VERSION "6.0")
set(CONAN_SETTINGS_CPPSTD "17")
set(CONAN_SETTINGS_OS "Linux")
set(CONAN_SETTINGS_OS_BUILD "Linux")

set(CONAN_DEPENDENCIES binutils vmrunner vmbuild chainloader diskbuilder protoc_installer includeos protobuf GSL libgcc rapidjson http-parser uzlib botan s2n openssl libcxx musl libunwind libcxxabi)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/include"
			"/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/include/os"
			"/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/include"
			"/home/vagrant/.conan/data/GSL/2.0.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/vagrant/.conan/data/rapidjson/1.1.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include"
			"/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include"
			"/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/include"
			"/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/include"
			"/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/include"
			"/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/include"
			"/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/include/c++/v1"
			"/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/include"
			"/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/include"
			"/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/lib"
			"/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/lib"
			"/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/lib"
			"/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/platform"
			"/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/lib"
			"/home/vagrant/.conan/data/libgcc/1.0/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/lib"
			"/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib"
			"/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib"
			"/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/lib"
			"/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/lib"
			"/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/lib"
			"/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/lib"
			"/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/lib"
			"/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/lib"
			"/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/bin"
			"/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin"
			"/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin"
			"/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/bin"
			"/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/bin"
			"/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS "/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2" ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS os arch musl_syscalls x86_64_pc protoc protobuf compiler http-parser tinf s2n crypto ssl c++ c++experimental c crypt m rt dl pthread resolv util xnet unwind c++abi ${CONAN_LIBS})
set(CONAN_PKG_LIBS os arch musl_syscalls x86_64_pc protoc protobuf compiler http-parser tinf s2n crypto ssl c++ c++experimental c crypt m rt dl pthread resolv util xnet unwind c++abi ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS )
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES  ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS  ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "/home/vagrant/.conan/data/binutils/2.31/includeos/toolchain/package/0b18460aeb1058d7174e2cd4df4095ee9cfb1cb6/"
			"/home/vagrant/.conan/data/vmrunner/0.16.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/vagrant/.conan/data/vmbuild/0.15.1-15/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/"
			"/home/vagrant/.conan/data/chainloader/0.15.1-5/includeos/latest/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/vagrant/.conan/data/diskbuilder/0.15.1-14/includeos/latest/package/44fcf6b9a7fb86b2586303e3db40189d3b511830/"
			"/home/vagrant/.conan/data/protoc_installer/3.6.1/bincrafters/stable/package/c0c1ef10e3d0ded44179e28b669d6aed0277ca6a/"
			"/home/vagrant/.conan/data/includeos/0.15.1-5/includeos/latest/package/e70c8745fe4aa8eea40e3372373944d2a5e7f7e2/cmake"
			"/home/vagrant/.conan/data/protobuf/3.6.1/bincrafters/stable/package/a90dfc6d67d865c90c5681f9f689d5864aac8e3d/"
			"/home/vagrant/.conan/data/GSL/2.0.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/vagrant/.conan/data/libgcc/1.0/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/"
			"/home/vagrant/.conan/data/rapidjson/1.1.0/includeos/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/vagrant/.conan/data/http-parser/2.8.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/"
			"/home/vagrant/.conan/data/uzlib/v2.1.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/"
			"/home/vagrant/.conan/data/botan/2.8.0/includeos/stable/package/86ea9478749b6b151377a318eab036c1a5c76d6f/"
			"/home/vagrant/.conan/data/s2n/0.8/includeos/stable/package/c66c28cef47ff50b0bffd409ac60e5bcc7601da5/"
			"/home/vagrant/.conan/data/openssl/1.1.1/includeos/stable/package/a15f421984675bd76e8df07971c322909358ebd9/"
			"/home/vagrant/.conan/data/libcxx/7.0.1/includeos/stable/package/1a6e18396c747cde73f080a5f492b49fcefbb012/"
			"/home/vagrant/.conan/data/musl/1.1.18/includeos/stable/package/b6ca6a0ffff110bf17b843d4258482a94281eb43/"
			"/home/vagrant/.conan/data/libunwind/7.0.1/includeos/stable/package/c78b30f867758f14db30f570224a7f03bf7ddfab/"
			"/home/vagrant/.conan/data/libcxxabi/7.0.1/includeos/stable/package/5d88dc4b26402479b7aa0fcb29ca9b9c28da4c9f/" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}")
# Append to aggregated values variable
set(CONAN_LIBS ${CONAN_PKG_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BINUTILS}" "${CONAN_LIB_DIRS_BINUTILS}"
                                  CONAN_PACKAGE_TARGETS_BINUTILS "${CONAN_SYSTEM_LIBS_BINUTILS} "
                                  "" binutils)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BINUTILS_DEBUG}" "${CONAN_LIB_DIRS_BINUTILS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BINUTILS_DEBUG "${CONAN_SYSTEM_LIBS_BINUTILS_DEBUG} "
                                  "debug" binutils)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BINUTILS_RELEASE}" "${CONAN_LIB_DIRS_BINUTILS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BINUTILS_RELEASE "${CONAN_SYSTEM_LIBS_BINUTILS_RELEASE} "
                                  "release" binutils)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BINUTILS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BINUTILS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BINUTILS_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BINUTILS_RELWITHDEBINFO} "
                                  "relwithdebinfo" binutils)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BINUTILS_MINSIZEREL}" "${CONAN_LIB_DIRS_BINUTILS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BINUTILS_MINSIZEREL "${CONAN_SYSTEM_LIBS_BINUTILS_MINSIZEREL} "
                                  "minsizerel" binutils)

    add_library(CONAN_PKG::binutils INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::binutils PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BINUTILS} ${CONAN_SHARED_LINKER_FLAGS_BINUTILS_LIST} ${CONAN_EXE_LINKER_FLAGS_BINUTILS_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BINUTILS_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_BINUTILS_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_BINUTILS_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BINUTILS_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_BINUTILS_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_BINUTILS_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BINUTILS_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_BINUTILS_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_BINUTILS_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BINUTILS_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_BINUTILS_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_BINUTILS_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::binutils PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BINUTILS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BINUTILS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BINUTILS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BINUTILS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BINUTILS_DEBUG}>)
    set_property(TARGET CONAN_PKG::binutils PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BINUTILS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BINUTILS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BINUTILS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BINUTILS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BINUTILS_DEBUG}>)
    set_property(TARGET CONAN_PKG::binutils PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BINUTILS_LIST} ${CONAN_CXX_FLAGS_BINUTILS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BINUTILS_RELEASE_LIST} ${CONAN_CXX_FLAGS_BINUTILS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BINUTILS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BINUTILS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BINUTILS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BINUTILS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BINUTILS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BINUTILS_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMRUNNER}" "${CONAN_LIB_DIRS_VMRUNNER}"
                                  CONAN_PACKAGE_TARGETS_VMRUNNER "${CONAN_SYSTEM_LIBS_VMRUNNER} "
                                  "" vmrunner)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMRUNNER_DEBUG}" "${CONAN_LIB_DIRS_VMRUNNER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VMRUNNER_DEBUG "${CONAN_SYSTEM_LIBS_VMRUNNER_DEBUG} "
                                  "debug" vmrunner)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMRUNNER_RELEASE}" "${CONAN_LIB_DIRS_VMRUNNER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VMRUNNER_RELEASE "${CONAN_SYSTEM_LIBS_VMRUNNER_RELEASE} "
                                  "release" vmrunner)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMRUNNER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VMRUNNER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VMRUNNER_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VMRUNNER_RELWITHDEBINFO} "
                                  "relwithdebinfo" vmrunner)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMRUNNER_MINSIZEREL}" "${CONAN_LIB_DIRS_VMRUNNER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VMRUNNER_MINSIZEREL "${CONAN_SYSTEM_LIBS_VMRUNNER_MINSIZEREL} "
                                  "minsizerel" vmrunner)

    add_library(CONAN_PKG::vmrunner INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vmrunner PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VMRUNNER} ${CONAN_SHARED_LINKER_FLAGS_VMRUNNER_LIST} ${CONAN_EXE_LINKER_FLAGS_VMRUNNER_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VMRUNNER_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_VMRUNNER_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_VMRUNNER_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VMRUNNER_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_VMRUNNER_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_VMRUNNER_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VMRUNNER_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_VMRUNNER_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_VMRUNNER_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VMRUNNER_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_VMRUNNER_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_VMRUNNER_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::vmrunner PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VMRUNNER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VMRUNNER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VMRUNNER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VMRUNNER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VMRUNNER_DEBUG}>)
    set_property(TARGET CONAN_PKG::vmrunner PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VMRUNNER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VMRUNNER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VMRUNNER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VMRUNNER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VMRUNNER_DEBUG}>)
    set_property(TARGET CONAN_PKG::vmrunner PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VMRUNNER_LIST} ${CONAN_CXX_FLAGS_VMRUNNER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VMRUNNER_RELEASE_LIST} ${CONAN_CXX_FLAGS_VMRUNNER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VMRUNNER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VMRUNNER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VMRUNNER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VMRUNNER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VMRUNNER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VMRUNNER_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMBUILD}" "${CONAN_LIB_DIRS_VMBUILD}"
                                  CONAN_PACKAGE_TARGETS_VMBUILD "${CONAN_SYSTEM_LIBS_VMBUILD} "
                                  "" vmbuild)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMBUILD_DEBUG}" "${CONAN_LIB_DIRS_VMBUILD_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VMBUILD_DEBUG "${CONAN_SYSTEM_LIBS_VMBUILD_DEBUG} "
                                  "debug" vmbuild)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMBUILD_RELEASE}" "${CONAN_LIB_DIRS_VMBUILD_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VMBUILD_RELEASE "${CONAN_SYSTEM_LIBS_VMBUILD_RELEASE} "
                                  "release" vmbuild)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMBUILD_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VMBUILD_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VMBUILD_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VMBUILD_RELWITHDEBINFO} "
                                  "relwithdebinfo" vmbuild)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_VMBUILD_MINSIZEREL}" "${CONAN_LIB_DIRS_VMBUILD_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VMBUILD_MINSIZEREL "${CONAN_SYSTEM_LIBS_VMBUILD_MINSIZEREL} "
                                  "minsizerel" vmbuild)

    add_library(CONAN_PKG::vmbuild INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vmbuild PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VMBUILD} ${CONAN_SHARED_LINKER_FLAGS_VMBUILD_LIST} ${CONAN_EXE_LINKER_FLAGS_VMBUILD_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VMBUILD_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_VMBUILD_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_VMBUILD_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VMBUILD_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_VMBUILD_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_VMBUILD_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VMBUILD_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_VMBUILD_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_VMBUILD_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VMBUILD_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_VMBUILD_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_VMBUILD_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::vmbuild PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VMBUILD}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VMBUILD_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VMBUILD_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VMBUILD_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VMBUILD_DEBUG}>)
    set_property(TARGET CONAN_PKG::vmbuild PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VMBUILD}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VMBUILD_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VMBUILD_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VMBUILD_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VMBUILD_DEBUG}>)
    set_property(TARGET CONAN_PKG::vmbuild PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VMBUILD_LIST} ${CONAN_CXX_FLAGS_VMBUILD_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VMBUILD_RELEASE_LIST} ${CONAN_CXX_FLAGS_VMBUILD_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VMBUILD_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VMBUILD_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VMBUILD_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VMBUILD_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VMBUILD_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VMBUILD_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_CHAINLOADER}" "${CONAN_LIB_DIRS_CHAINLOADER}"
                                  CONAN_PACKAGE_TARGETS_CHAINLOADER "${CONAN_SYSTEM_LIBS_CHAINLOADER} "
                                  "" chainloader)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_CHAINLOADER_DEBUG}" "${CONAN_LIB_DIRS_CHAINLOADER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_CHAINLOADER_DEBUG "${CONAN_SYSTEM_LIBS_CHAINLOADER_DEBUG} "
                                  "debug" chainloader)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_CHAINLOADER_RELEASE}" "${CONAN_LIB_DIRS_CHAINLOADER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_CHAINLOADER_RELEASE "${CONAN_SYSTEM_LIBS_CHAINLOADER_RELEASE} "
                                  "release" chainloader)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_CHAINLOADER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_CHAINLOADER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_CHAINLOADER_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_CHAINLOADER_RELWITHDEBINFO} "
                                  "relwithdebinfo" chainloader)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_CHAINLOADER_MINSIZEREL}" "${CONAN_LIB_DIRS_CHAINLOADER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_CHAINLOADER_MINSIZEREL "${CONAN_SYSTEM_LIBS_CHAINLOADER_MINSIZEREL} "
                                  "minsizerel" chainloader)

    add_library(CONAN_PKG::chainloader INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::chainloader PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_CHAINLOADER} ${CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_LIST} ${CONAN_EXE_LINKER_FLAGS_CHAINLOADER_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_CHAINLOADER_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_CHAINLOADER_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_CHAINLOADER_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_CHAINLOADER_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_CHAINLOADER_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_CHAINLOADER_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_CHAINLOADER_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_CHAINLOADER_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_CHAINLOADER_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::chainloader PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_CHAINLOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_CHAINLOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_CHAINLOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_CHAINLOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_CHAINLOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::chainloader PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_CHAINLOADER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_CHAINLOADER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_CHAINLOADER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_CHAINLOADER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_CHAINLOADER_DEBUG}>)
    set_property(TARGET CONAN_PKG::chainloader PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_CHAINLOADER_LIST} ${CONAN_CXX_FLAGS_CHAINLOADER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_CHAINLOADER_RELEASE_LIST} ${CONAN_CXX_FLAGS_CHAINLOADER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_CHAINLOADER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_CHAINLOADER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_CHAINLOADER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_CHAINLOADER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_CHAINLOADER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_CHAINLOADER_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_DISKBUILDER}" "${CONAN_LIB_DIRS_DISKBUILDER}"
                                  CONAN_PACKAGE_TARGETS_DISKBUILDER "${CONAN_SYSTEM_LIBS_DISKBUILDER} "
                                  "" diskbuilder)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_DISKBUILDER_DEBUG}" "${CONAN_LIB_DIRS_DISKBUILDER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_DISKBUILDER_DEBUG "${CONAN_SYSTEM_LIBS_DISKBUILDER_DEBUG} "
                                  "debug" diskbuilder)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_DISKBUILDER_RELEASE}" "${CONAN_LIB_DIRS_DISKBUILDER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_DISKBUILDER_RELEASE "${CONAN_SYSTEM_LIBS_DISKBUILDER_RELEASE} "
                                  "release" diskbuilder)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_DISKBUILDER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_DISKBUILDER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_DISKBUILDER_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_DISKBUILDER_RELWITHDEBINFO} "
                                  "relwithdebinfo" diskbuilder)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_DISKBUILDER_MINSIZEREL}" "${CONAN_LIB_DIRS_DISKBUILDER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_DISKBUILDER_MINSIZEREL "${CONAN_SYSTEM_LIBS_DISKBUILDER_MINSIZEREL} "
                                  "minsizerel" diskbuilder)

    add_library(CONAN_PKG::diskbuilder INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::diskbuilder PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_DISKBUILDER} ${CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_LIST} ${CONAN_EXE_LINKER_FLAGS_DISKBUILDER_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_DISKBUILDER_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_DISKBUILDER_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_DISKBUILDER_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_DISKBUILDER_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_DISKBUILDER_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_DISKBUILDER_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_DISKBUILDER_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_DISKBUILDER_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_DISKBUILDER_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::diskbuilder PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_DISKBUILDER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_DISKBUILDER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_DISKBUILDER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_DISKBUILDER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DISKBUILDER_DEBUG}>)
    set_property(TARGET CONAN_PKG::diskbuilder PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_DISKBUILDER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_DISKBUILDER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_DISKBUILDER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_DISKBUILDER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_DISKBUILDER_DEBUG}>)
    set_property(TARGET CONAN_PKG::diskbuilder PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_DISKBUILDER_LIST} ${CONAN_CXX_FLAGS_DISKBUILDER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_DISKBUILDER_RELEASE_LIST} ${CONAN_CXX_FLAGS_DISKBUILDER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_DISKBUILDER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_DISKBUILDER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_DISKBUILDER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_DISKBUILDER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_DISKBUILDER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_DISKBUILDER_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER}" "${CONAN_LIB_DIRS_PROTOC_INSTALLER}"
                                  CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER "${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER} "
                                  "" protoc_installer)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER_DEBUG}" "${CONAN_LIB_DIRS_PROTOC_INSTALLER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_DEBUG "${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER_DEBUG} "
                                  "debug" protoc_installer)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER_RELEASE}" "${CONAN_LIB_DIRS_PROTOC_INSTALLER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_RELEASE "${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER_RELEASE} "
                                  "release" protoc_installer)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_PROTOC_INSTALLER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER_RELWITHDEBINFO} "
                                  "relwithdebinfo" protoc_installer)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOC_INSTALLER_MINSIZEREL}" "${CONAN_LIB_DIRS_PROTOC_INSTALLER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_MINSIZEREL "${CONAN_SYSTEM_LIBS_PROTOC_INSTALLER_MINSIZEREL} "
                                  "minsizerel" protoc_installer)

    add_library(CONAN_PKG::protoc_installer INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::protoc_installer PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER} ${CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_PROTOC_INSTALLER_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_PROTOC_INSTALLER_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOC_INSTALLER_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::protoc_installer PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_PROTOC_INSTALLER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_PROTOC_INSTALLER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_PROTOC_INSTALLER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_PROTOC_INSTALLER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_PROTOC_INSTALLER_DEBUG}>)
    set_property(TARGET CONAN_PKG::protoc_installer PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_PROTOC_INSTALLER_DEBUG}>)
    set_property(TARGET CONAN_PKG::protoc_installer PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_PROTOC_INSTALLER_LIST} ${CONAN_CXX_FLAGS_PROTOC_INSTALLER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_PROTOC_INSTALLER_RELEASE_LIST} ${CONAN_CXX_FLAGS_PROTOC_INSTALLER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_PROTOC_INSTALLER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_PROTOC_INSTALLER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_PROTOC_INSTALLER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_PROTOC_INSTALLER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_PROTOC_INSTALLER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_PROTOC_INSTALLER_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_INCLUDEOS}" "${CONAN_LIB_DIRS_INCLUDEOS}"
                                  CONAN_PACKAGE_TARGETS_INCLUDEOS "${CONAN_SYSTEM_LIBS_INCLUDEOS} CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n"
                                  "" includeos)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_INCLUDEOS_DEBUG}" "${CONAN_LIB_DIRS_INCLUDEOS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_INCLUDEOS_DEBUG "${CONAN_SYSTEM_LIBS_INCLUDEOS_DEBUG} CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n"
                                  "debug" includeos)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_INCLUDEOS_RELEASE}" "${CONAN_LIB_DIRS_INCLUDEOS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_INCLUDEOS_RELEASE "${CONAN_SYSTEM_LIBS_INCLUDEOS_RELEASE} CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n"
                                  "release" includeos)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_INCLUDEOS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_INCLUDEOS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_INCLUDEOS_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_INCLUDEOS_RELWITHDEBINFO} CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n"
                                  "relwithdebinfo" includeos)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_INCLUDEOS_MINSIZEREL}" "${CONAN_LIB_DIRS_INCLUDEOS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_INCLUDEOS_MINSIZEREL "${CONAN_SYSTEM_LIBS_INCLUDEOS_MINSIZEREL} CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n"
                                  "minsizerel" includeos)

    add_library(CONAN_PKG::includeos INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::includeos PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_INCLUDEOS} ${CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_LIST} ${CONAN_EXE_LINKER_FLAGS_INCLUDEOS_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_INCLUDEOS_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_INCLUDEOS_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_INCLUDEOS_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_INCLUDEOS_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_INCLUDEOS_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_INCLUDEOS_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_INCLUDEOS_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_INCLUDEOS_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_INCLUDEOS_DEBUG_LIST}>
                                                                 CONAN_PKG::GSL CONAN_PKG::libcxx CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n)
    set_property(TARGET CONAN_PKG::includeos PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_INCLUDEOS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_INCLUDEOS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_INCLUDEOS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_INCLUDEOS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_INCLUDEOS_DEBUG}>)
    set_property(TARGET CONAN_PKG::includeos PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_INCLUDEOS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_INCLUDEOS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_INCLUDEOS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_INCLUDEOS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_INCLUDEOS_DEBUG}>)
    set_property(TARGET CONAN_PKG::includeos PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_INCLUDEOS_LIST} ${CONAN_CXX_FLAGS_INCLUDEOS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_INCLUDEOS_RELEASE_LIST} ${CONAN_CXX_FLAGS_INCLUDEOS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_INCLUDEOS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_INCLUDEOS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_INCLUDEOS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_INCLUDEOS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_INCLUDEOS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_INCLUDEOS_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOBUF}" "${CONAN_LIB_DIRS_PROTOBUF}"
                                  CONAN_PACKAGE_TARGETS_PROTOBUF "${CONAN_SYSTEM_LIBS_PROTOBUF} "
                                  "" protobuf)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOBUF_DEBUG}" "${CONAN_LIB_DIRS_PROTOBUF_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_PROTOBUF_DEBUG "${CONAN_SYSTEM_LIBS_PROTOBUF_DEBUG} "
                                  "debug" protobuf)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOBUF_RELEASE}" "${CONAN_LIB_DIRS_PROTOBUF_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_PROTOBUF_RELEASE "${CONAN_SYSTEM_LIBS_PROTOBUF_RELEASE} "
                                  "release" protobuf)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOBUF_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_PROTOBUF_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_PROTOBUF_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_PROTOBUF_RELWITHDEBINFO} "
                                  "relwithdebinfo" protobuf)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_PROTOBUF_MINSIZEREL}" "${CONAN_LIB_DIRS_PROTOBUF_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_PROTOBUF_MINSIZEREL "${CONAN_SYSTEM_LIBS_PROTOBUF_MINSIZEREL} "
                                  "minsizerel" protobuf)

    add_library(CONAN_PKG::protobuf INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::protobuf PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_PROTOBUF} ${CONAN_SHARED_LINKER_FLAGS_PROTOBUF_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOBUF_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_PROTOBUF_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_PROTOBUF_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOBUF_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_PROTOBUF_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_PROTOBUF_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOBUF_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_PROTOBUF_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_PROTOBUF_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOBUF_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_PROTOBUF_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_PROTOBUF_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_PROTOBUF_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::protobuf PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_PROTOBUF}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_PROTOBUF_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_PROTOBUF_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_PROTOBUF_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_PROTOBUF_DEBUG}>)
    set_property(TARGET CONAN_PKG::protobuf PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_PROTOBUF}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_PROTOBUF_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_PROTOBUF_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_PROTOBUF_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_PROTOBUF_DEBUG}>)
    set_property(TARGET CONAN_PKG::protobuf PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_PROTOBUF_LIST} ${CONAN_CXX_FLAGS_PROTOBUF_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_PROTOBUF_RELEASE_LIST} ${CONAN_CXX_FLAGS_PROTOBUF_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_PROTOBUF_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_PROTOBUF_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_PROTOBUF_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_PROTOBUF_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_PROTOBUF_DEBUG_LIST}  ${CONAN_CXX_FLAGS_PROTOBUF_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_GSL}" "${CONAN_LIB_DIRS_GSL}"
                                  CONAN_PACKAGE_TARGETS_GSL "${CONAN_SYSTEM_LIBS_GSL} "
                                  "" GSL)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_GSL_DEBUG}" "${CONAN_LIB_DIRS_GSL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GSL_DEBUG "${CONAN_SYSTEM_LIBS_GSL_DEBUG} "
                                  "debug" GSL)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_GSL_RELEASE}" "${CONAN_LIB_DIRS_GSL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GSL_RELEASE "${CONAN_SYSTEM_LIBS_GSL_RELEASE} "
                                  "release" GSL)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_GSL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GSL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GSL_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GSL_RELWITHDEBINFO} "
                                  "relwithdebinfo" GSL)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_GSL_MINSIZEREL}" "${CONAN_LIB_DIRS_GSL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GSL_MINSIZEREL "${CONAN_SYSTEM_LIBS_GSL_MINSIZEREL} "
                                  "minsizerel" GSL)

    add_library(CONAN_PKG::GSL INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::GSL PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GSL} ${CONAN_SHARED_LINKER_FLAGS_GSL_LIST} ${CONAN_EXE_LINKER_FLAGS_GSL_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GSL_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_GSL_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_GSL_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GSL_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_GSL_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_GSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GSL_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_GSL_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_GSL_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GSL_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_GSL_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_GSL_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::GSL PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GSL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::GSL PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GSL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::GSL PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GSL_LIST} ${CONAN_CXX_FLAGS_GSL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GSL_RELEASE_LIST} ${CONAN_CXX_FLAGS_GSL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GSL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GSL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GSL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GSL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GSL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GSL_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBGCC}" "${CONAN_LIB_DIRS_LIBGCC}"
                                  CONAN_PACKAGE_TARGETS_LIBGCC "${CONAN_SYSTEM_LIBS_LIBGCC} "
                                  "" libgcc)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBGCC_DEBUG}" "${CONAN_LIB_DIRS_LIBGCC_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBGCC_DEBUG "${CONAN_SYSTEM_LIBS_LIBGCC_DEBUG} "
                                  "debug" libgcc)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBGCC_RELEASE}" "${CONAN_LIB_DIRS_LIBGCC_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBGCC_RELEASE "${CONAN_SYSTEM_LIBS_LIBGCC_RELEASE} "
                                  "release" libgcc)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBGCC_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBGCC_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBGCC_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBGCC_RELWITHDEBINFO} "
                                  "relwithdebinfo" libgcc)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBGCC_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBGCC_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBGCC_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBGCC_MINSIZEREL} "
                                  "minsizerel" libgcc)

    add_library(CONAN_PKG::libgcc INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libgcc PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBGCC} ${CONAN_SHARED_LINKER_FLAGS_LIBGCC_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBGCC_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBGCC_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_LIBGCC_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBGCC_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBGCC_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_LIBGCC_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBGCC_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBGCC_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_LIBGCC_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBGCC_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBGCC_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_LIBGCC_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBGCC_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::libgcc PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBGCC}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBGCC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBGCC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBGCC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBGCC_DEBUG}>)
    set_property(TARGET CONAN_PKG::libgcc PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBGCC}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBGCC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBGCC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBGCC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBGCC_DEBUG}>)
    set_property(TARGET CONAN_PKG::libgcc PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBGCC_LIST} ${CONAN_CXX_FLAGS_LIBGCC_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBGCC_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBGCC_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBGCC_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBGCC_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBGCC_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBGCC_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBGCC_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBGCC_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_RAPIDJSON}" "${CONAN_LIB_DIRS_RAPIDJSON}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON "${CONAN_SYSTEM_LIBS_RAPIDJSON} "
                                  "" rapidjson)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_RAPIDJSON_DEBUG}" "${CONAN_LIB_DIRS_RAPIDJSON_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_DEBUG "${CONAN_SYSTEM_LIBS_RAPIDJSON_DEBUG} "
                                  "debug" rapidjson)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_RAPIDJSON_RELEASE}" "${CONAN_LIB_DIRS_RAPIDJSON_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_RELEASE "${CONAN_SYSTEM_LIBS_RAPIDJSON_RELEASE} "
                                  "release" rapidjson)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_RAPIDJSON_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RAPIDJSON_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_RAPIDJSON_RELWITHDEBINFO} "
                                  "relwithdebinfo" rapidjson)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_RAPIDJSON_MINSIZEREL}" "${CONAN_LIB_DIRS_RAPIDJSON_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_MINSIZEREL "${CONAN_SYSTEM_LIBS_RAPIDJSON_MINSIZEREL} "
                                  "minsizerel" rapidjson)

    add_library(CONAN_PKG::rapidjson INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_RAPIDJSON} ${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_LIST} ${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_RAPIDJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RAPIDJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RAPIDJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_RAPIDJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_RAPIDJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_RAPIDJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_RAPIDJSON_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_RAPIDJSON_RELEASE_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_RAPIDJSON_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_RAPIDJSON_DEBUG_LIST}  ${CONAN_CXX_FLAGS_RAPIDJSON_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_HTTP-PARSER}" "${CONAN_LIB_DIRS_HTTP-PARSER}"
                                  CONAN_PACKAGE_TARGETS_HTTP-PARSER "${CONAN_SYSTEM_LIBS_HTTP-PARSER} "
                                  "" http-parser)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_HTTP-PARSER_DEBUG}" "${CONAN_LIB_DIRS_HTTP-PARSER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_HTTP-PARSER_DEBUG "${CONAN_SYSTEM_LIBS_HTTP-PARSER_DEBUG} "
                                  "debug" http-parser)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_HTTP-PARSER_RELEASE}" "${CONAN_LIB_DIRS_HTTP-PARSER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_HTTP-PARSER_RELEASE "${CONAN_SYSTEM_LIBS_HTTP-PARSER_RELEASE} "
                                  "release" http-parser)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_HTTP-PARSER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_HTTP-PARSER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_HTTP-PARSER_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_HTTP-PARSER_RELWITHDEBINFO} "
                                  "relwithdebinfo" http-parser)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_HTTP-PARSER_MINSIZEREL}" "${CONAN_LIB_DIRS_HTTP-PARSER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_HTTP-PARSER_MINSIZEREL "${CONAN_SYSTEM_LIBS_HTTP-PARSER_MINSIZEREL} "
                                  "minsizerel" http-parser)

    add_library(CONAN_PKG::http-parser INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::http-parser PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_HTTP-PARSER} ${CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_LIST} ${CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_HTTP-PARSER_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_HTTP-PARSER_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_HTTP-PARSER_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_HTTP-PARSER_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_HTTP-PARSER_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_HTTP-PARSER_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::http-parser PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_HTTP-PARSER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_HTTP-PARSER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_HTTP-PARSER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_HTTP-PARSER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_HTTP-PARSER_DEBUG}>)
    set_property(TARGET CONAN_PKG::http-parser PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_HTTP-PARSER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_HTTP-PARSER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_HTTP-PARSER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_HTTP-PARSER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_HTTP-PARSER_DEBUG}>)
    set_property(TARGET CONAN_PKG::http-parser PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_HTTP-PARSER_LIST} ${CONAN_CXX_FLAGS_HTTP-PARSER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_HTTP-PARSER_RELEASE_LIST} ${CONAN_CXX_FLAGS_HTTP-PARSER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_HTTP-PARSER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_HTTP-PARSER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_HTTP-PARSER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_HTTP-PARSER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_HTTP-PARSER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_HTTP-PARSER_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_UZLIB}" "${CONAN_LIB_DIRS_UZLIB}"
                                  CONAN_PACKAGE_TARGETS_UZLIB "${CONAN_SYSTEM_LIBS_UZLIB} "
                                  "" uzlib)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_UZLIB_DEBUG}" "${CONAN_LIB_DIRS_UZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_UZLIB_DEBUG "${CONAN_SYSTEM_LIBS_UZLIB_DEBUG} "
                                  "debug" uzlib)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_UZLIB_RELEASE}" "${CONAN_LIB_DIRS_UZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_UZLIB_RELEASE "${CONAN_SYSTEM_LIBS_UZLIB_RELEASE} "
                                  "release" uzlib)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_UZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_UZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_UZLIB_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_UZLIB_RELWITHDEBINFO} "
                                  "relwithdebinfo" uzlib)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_UZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_UZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_UZLIB_MINSIZEREL "${CONAN_SYSTEM_LIBS_UZLIB_MINSIZEREL} "
                                  "minsizerel" uzlib)

    add_library(CONAN_PKG::uzlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::uzlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_UZLIB} ${CONAN_SHARED_LINKER_FLAGS_UZLIB_LIST} ${CONAN_EXE_LINKER_FLAGS_UZLIB_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_UZLIB_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_UZLIB_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_UZLIB_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_UZLIB_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_UZLIB_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_UZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_UZLIB_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_UZLIB_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_UZLIB_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_UZLIB_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_UZLIB_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_UZLIB_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::uzlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_UZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_UZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_UZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_UZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_UZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::uzlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_UZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_UZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_UZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_UZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_UZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::uzlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_UZLIB_LIST} ${CONAN_CXX_FLAGS_UZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_UZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_UZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_UZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_UZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_UZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_UZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_UZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_UZLIB_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BOTAN}" "${CONAN_LIB_DIRS_BOTAN}"
                                  CONAN_PACKAGE_TARGETS_BOTAN "${CONAN_SYSTEM_LIBS_BOTAN} CONAN_PKG::libcxx CONAN_PKG::musl"
                                  "" botan)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BOTAN_DEBUG}" "${CONAN_LIB_DIRS_BOTAN_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BOTAN_DEBUG "${CONAN_SYSTEM_LIBS_BOTAN_DEBUG} CONAN_PKG::libcxx CONAN_PKG::musl"
                                  "debug" botan)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BOTAN_RELEASE}" "${CONAN_LIB_DIRS_BOTAN_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BOTAN_RELEASE "${CONAN_SYSTEM_LIBS_BOTAN_RELEASE} CONAN_PKG::libcxx CONAN_PKG::musl"
                                  "release" botan)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BOTAN_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BOTAN_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BOTAN_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BOTAN_RELWITHDEBINFO} CONAN_PKG::libcxx CONAN_PKG::musl"
                                  "relwithdebinfo" botan)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_BOTAN_MINSIZEREL}" "${CONAN_LIB_DIRS_BOTAN_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BOTAN_MINSIZEREL "${CONAN_SYSTEM_LIBS_BOTAN_MINSIZEREL} CONAN_PKG::libcxx CONAN_PKG::musl"
                                  "minsizerel" botan)

    add_library(CONAN_PKG::botan INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::botan PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BOTAN} ${CONAN_SHARED_LINKER_FLAGS_BOTAN_LIST} ${CONAN_EXE_LINKER_FLAGS_BOTAN_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BOTAN_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_BOTAN_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_BOTAN_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BOTAN_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_BOTAN_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_BOTAN_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BOTAN_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_BOTAN_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_BOTAN_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BOTAN_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_BOTAN_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_BOTAN_DEBUG_LIST}>
                                                                 CONAN_PKG::libcxx CONAN_PKG::musl)
    set_property(TARGET CONAN_PKG::botan PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BOTAN}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BOTAN_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BOTAN_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BOTAN_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BOTAN_DEBUG}>)
    set_property(TARGET CONAN_PKG::botan PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BOTAN}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BOTAN_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BOTAN_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BOTAN_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BOTAN_DEBUG}>)
    set_property(TARGET CONAN_PKG::botan PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BOTAN_LIST} ${CONAN_CXX_FLAGS_BOTAN_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BOTAN_RELEASE_LIST} ${CONAN_CXX_FLAGS_BOTAN_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BOTAN_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BOTAN_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BOTAN_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BOTAN_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BOTAN_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BOTAN_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_S2N}" "${CONAN_LIB_DIRS_S2N}"
                                  CONAN_PACKAGE_TARGETS_S2N "${CONAN_SYSTEM_LIBS_S2N} CONAN_PKG::openssl"
                                  "" s2n)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_S2N_DEBUG}" "${CONAN_LIB_DIRS_S2N_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_S2N_DEBUG "${CONAN_SYSTEM_LIBS_S2N_DEBUG} CONAN_PKG::openssl"
                                  "debug" s2n)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_S2N_RELEASE}" "${CONAN_LIB_DIRS_S2N_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_S2N_RELEASE "${CONAN_SYSTEM_LIBS_S2N_RELEASE} CONAN_PKG::openssl"
                                  "release" s2n)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_S2N_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_S2N_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_S2N_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_S2N_RELWITHDEBINFO} CONAN_PKG::openssl"
                                  "relwithdebinfo" s2n)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_S2N_MINSIZEREL}" "${CONAN_LIB_DIRS_S2N_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_S2N_MINSIZEREL "${CONAN_SYSTEM_LIBS_S2N_MINSIZEREL} CONAN_PKG::openssl"
                                  "minsizerel" s2n)

    add_library(CONAN_PKG::s2n INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::s2n PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_S2N} ${CONAN_SHARED_LINKER_FLAGS_S2N_LIST} ${CONAN_EXE_LINKER_FLAGS_S2N_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_S2N_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_S2N_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_S2N_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_S2N_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_S2N_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_S2N_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_S2N_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_S2N_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_S2N_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_S2N_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_S2N_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_S2N_DEBUG_LIST}>
                                                                 CONAN_PKG::openssl)
    set_property(TARGET CONAN_PKG::s2n PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_S2N}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_S2N_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_S2N_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_S2N_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_S2N_DEBUG}>)
    set_property(TARGET CONAN_PKG::s2n PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_S2N}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_S2N_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_S2N_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_S2N_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_S2N_DEBUG}>)
    set_property(TARGET CONAN_PKG::s2n PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_S2N_LIST} ${CONAN_CXX_FLAGS_S2N_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_S2N_RELEASE_LIST} ${CONAN_CXX_FLAGS_S2N_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_S2N_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_S2N_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_S2N_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_S2N_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_S2N_DEBUG_LIST}  ${CONAN_CXX_FLAGS_S2N_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_OPENSSL}" "${CONAN_LIB_DIRS_OPENSSL}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL "${CONAN_SYSTEM_LIBS_OPENSSL} CONAN_PKG::libcxx"
                                  "" openssl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_OPENSSL_DEBUG}" "${CONAN_LIB_DIRS_OPENSSL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_DEBUG "${CONAN_SYSTEM_LIBS_OPENSSL_DEBUG} CONAN_PKG::libcxx"
                                  "debug" openssl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_OPENSSL_RELEASE}" "${CONAN_LIB_DIRS_OPENSSL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_RELEASE "${CONAN_SYSTEM_LIBS_OPENSSL_RELEASE} CONAN_PKG::libcxx"
                                  "release" openssl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_OPENSSL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENSSL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENSSL_RELWITHDEBINFO} CONAN_PKG::libcxx"
                                  "relwithdebinfo" openssl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_OPENSSL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENSSL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENSSL_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENSSL_MINSIZEREL} CONAN_PKG::libcxx"
                                  "minsizerel" openssl)

    add_library(CONAN_PKG::openssl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENSSL} ${CONAN_SHARED_LINKER_FLAGS_OPENSSL_LIST} ${CONAN_EXE_LINKER_FLAGS_OPENSSL_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENSSL_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_OPENSSL_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENSSL_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENSSL_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_OPENSSL_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_OPENSSL_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENSSL_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_OPENSSL_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_OPENSSL_DEBUG_LIST}>
                                                                 CONAN_PKG::libcxx)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENSSL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENSSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENSSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENSSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENSSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENSSL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENSSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openssl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENSSL_LIST} ${CONAN_CXX_FLAGS_OPENSSL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENSSL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENSSL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENSSL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENSSL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENSSL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENSSL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENSSL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENSSL_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXX}" "${CONAN_LIB_DIRS_LIBCXX}"
                                  CONAN_PACKAGE_TARGETS_LIBCXX "${CONAN_SYSTEM_LIBS_LIBCXX} CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi"
                                  "" libcxx)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXX_DEBUG}" "${CONAN_LIB_DIRS_LIBCXX_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBCXX_DEBUG "${CONAN_SYSTEM_LIBS_LIBCXX_DEBUG} CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi"
                                  "debug" libcxx)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXX_RELEASE}" "${CONAN_LIB_DIRS_LIBCXX_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBCXX_RELEASE "${CONAN_SYSTEM_LIBS_LIBCXX_RELEASE} CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi"
                                  "release" libcxx)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXX_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBCXX_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBCXX_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBCXX_RELWITHDEBINFO} CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi"
                                  "relwithdebinfo" libcxx)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXX_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBCXX_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBCXX_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBCXX_MINSIZEREL} CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi"
                                  "minsizerel" libcxx)

    add_library(CONAN_PKG::libcxx INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libcxx PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBCXX} ${CONAN_SHARED_LINKER_FLAGS_LIBCXX_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXX_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBCXX_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_LIBCXX_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXX_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBCXX_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_LIBCXX_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXX_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBCXX_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_LIBCXX_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXX_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBCXX_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_LIBCXX_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXX_DEBUG_LIST}>
                                                                 CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi)
    set_property(TARGET CONAN_PKG::libcxx PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBCXX}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBCXX_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBCXX_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBCXX_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBCXX_DEBUG}>)
    set_property(TARGET CONAN_PKG::libcxx PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBCXX}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBCXX_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBCXX_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBCXX_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBCXX_DEBUG}>)
    set_property(TARGET CONAN_PKG::libcxx PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBCXX_LIST} ${CONAN_CXX_FLAGS_LIBCXX_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBCXX_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBCXX_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBCXX_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBCXX_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBCXX_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBCXX_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBCXX_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBCXX_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_MUSL}" "${CONAN_LIB_DIRS_MUSL}"
                                  CONAN_PACKAGE_TARGETS_MUSL "${CONAN_SYSTEM_LIBS_MUSL} "
                                  "" musl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_MUSL_DEBUG}" "${CONAN_LIB_DIRS_MUSL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_MUSL_DEBUG "${CONAN_SYSTEM_LIBS_MUSL_DEBUG} "
                                  "debug" musl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_MUSL_RELEASE}" "${CONAN_LIB_DIRS_MUSL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_MUSL_RELEASE "${CONAN_SYSTEM_LIBS_MUSL_RELEASE} "
                                  "release" musl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_MUSL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_MUSL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_MUSL_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_MUSL_RELWITHDEBINFO} "
                                  "relwithdebinfo" musl)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_MUSL_MINSIZEREL}" "${CONAN_LIB_DIRS_MUSL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_MUSL_MINSIZEREL "${CONAN_SYSTEM_LIBS_MUSL_MINSIZEREL} "
                                  "minsizerel" musl)

    add_library(CONAN_PKG::musl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::musl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_MUSL} ${CONAN_SHARED_LINKER_FLAGS_MUSL_LIST} ${CONAN_EXE_LINKER_FLAGS_MUSL_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_MUSL_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_MUSL_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_MUSL_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_MUSL_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_MUSL_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_MUSL_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_MUSL_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_MUSL_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_MUSL_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_MUSL_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_MUSL_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_MUSL_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::musl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_MUSL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_MUSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_MUSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MUSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_MUSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::musl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_MUSL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_MUSL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_MUSL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_MUSL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_MUSL_DEBUG}>)
    set_property(TARGET CONAN_PKG::musl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_MUSL_LIST} ${CONAN_CXX_FLAGS_MUSL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_MUSL_RELEASE_LIST} ${CONAN_CXX_FLAGS_MUSL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_MUSL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_MUSL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_MUSL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_MUSL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_MUSL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_MUSL_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBUNWIND}" "${CONAN_LIB_DIRS_LIBUNWIND}"
                                  CONAN_PACKAGE_TARGETS_LIBUNWIND "${CONAN_SYSTEM_LIBS_LIBUNWIND} "
                                  "" libunwind)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBUNWIND_DEBUG}" "${CONAN_LIB_DIRS_LIBUNWIND_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBUNWIND_DEBUG "${CONAN_SYSTEM_LIBS_LIBUNWIND_DEBUG} "
                                  "debug" libunwind)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBUNWIND_RELEASE}" "${CONAN_LIB_DIRS_LIBUNWIND_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBUNWIND_RELEASE "${CONAN_SYSTEM_LIBS_LIBUNWIND_RELEASE} "
                                  "release" libunwind)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBUNWIND_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBUNWIND_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBUNWIND_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBUNWIND_RELWITHDEBINFO} "
                                  "relwithdebinfo" libunwind)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBUNWIND_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBUNWIND_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBUNWIND_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBUNWIND_MINSIZEREL} "
                                  "minsizerel" libunwind)

    add_library(CONAN_PKG::libunwind INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libunwind PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBUNWIND} ${CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBUNWIND_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBUNWIND_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBUNWIND_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBUNWIND_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBUNWIND_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBUNWIND_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBUNWIND_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBUNWIND_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_LIBUNWIND_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBUNWIND_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::libunwind PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBUNWIND}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBUNWIND_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBUNWIND_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBUNWIND_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBUNWIND_DEBUG}>)
    set_property(TARGET CONAN_PKG::libunwind PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBUNWIND}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBUNWIND_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBUNWIND_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBUNWIND_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBUNWIND_DEBUG}>)
    set_property(TARGET CONAN_PKG::libunwind PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBUNWIND_LIST} ${CONAN_CXX_FLAGS_LIBUNWIND_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBUNWIND_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBUNWIND_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBUNWIND_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBUNWIND_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBUNWIND_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBUNWIND_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBUNWIND_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBUNWIND_DEBUG_LIST}>)


    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXXABI}" "${CONAN_LIB_DIRS_LIBCXXABI}"
                                  CONAN_PACKAGE_TARGETS_LIBCXXABI "${CONAN_SYSTEM_LIBS_LIBCXXABI} "
                                  "" libcxxabi)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXXABI_DEBUG}" "${CONAN_LIB_DIRS_LIBCXXABI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBCXXABI_DEBUG "${CONAN_SYSTEM_LIBS_LIBCXXABI_DEBUG} "
                                  "debug" libcxxabi)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXXABI_RELEASE}" "${CONAN_LIB_DIRS_LIBCXXABI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBCXXABI_RELEASE "${CONAN_SYSTEM_LIBS_LIBCXXABI_RELEASE} "
                                  "release" libcxxabi)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXXABI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBCXXABI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBCXXABI_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBCXXABI_RELWITHDEBINFO} "
                                  "relwithdebinfo" libcxxabi)
    conan_package_library_targets("${CONAN_LIBS_FRAMEWORKS_LIBCXXABI_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBCXXABI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBCXXABI_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBCXXABI_MINSIZEREL} "
                                  "minsizerel" libcxxabi)

    add_library(CONAN_PKG::libcxxabi INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libcxxabi PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBCXXABI} ${CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXXABI_LIST}
                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBCXXABI_RELEASE} ${CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_RELEASE_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXXABI_RELEASE_LIST}>
                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBCXXABI_RELWITHDEBINFO} ${CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_RELWITHDEBINFO_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXXABI_RELWITHDEBINFO_LIST}>
                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBCXXABI_MINSIZEREL} ${CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_MINSIZEREL_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXXABI_MINSIZEREL_LIST}>
                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBCXXABI_DEBUG} ${CONAN_SHARED_LINKER_FLAGS_LIBCXXABI_DEBUG_LIST} ${CONAN_EXE_LINKER_FLAGS_LIBCXXABI_DEBUG_LIST}>
                                                                 )
    set_property(TARGET CONAN_PKG::libcxxabi PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBCXXABI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBCXXABI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBCXXABI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBCXXABI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBCXXABI_DEBUG}>)
    set_property(TARGET CONAN_PKG::libcxxabi PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBCXXABI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBCXXABI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBCXXABI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBCXXABI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBCXXABI_DEBUG}>)
    set_property(TARGET CONAN_PKG::libcxxabi PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBCXXABI_LIST} ${CONAN_CXX_FLAGS_LIBCXXABI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBCXXABI_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBCXXABI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBCXXABI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBCXXABI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBCXXABI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBCXXABI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBCXXABI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBCXXABI_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::binutils CONAN_PKG::vmrunner CONAN_PKG::vmbuild CONAN_PKG::chainloader CONAN_PKG::diskbuilder CONAN_PKG::protoc_installer CONAN_PKG::includeos CONAN_PKG::protobuf CONAN_PKG::GSL CONAN_PKG::libgcc CONAN_PKG::rapidjson CONAN_PKG::http-parser CONAN_PKG::uzlib CONAN_PKG::botan CONAN_PKG::s2n CONAN_PKG::openssl CONAN_PKG::libcxx CONAN_PKG::musl CONAN_PKG::libunwind CONAN_PKG::libcxxabi)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_message(STATUS "Conan: Adjusting language standard")
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()

macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()

macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()

macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                     CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                     CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
            if(DEFINED ${flag})
                string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
            endif()
        endforeach()
        foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
            if(DEFINED ${flag})
                string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
            endif()
        endforeach()
    endif()
endmacro()

macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()

function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()

function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        unset(CONAN_FOUND_LIBRARY CACHE)
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
    endforeach()
    unset(CONAN_FOUND_LIBRARY CACHE)
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()

function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    foreach(_LIBRARY_NAME ${libraries})
        unset(CONAN_FOUND_LIBRARY CACHE)
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            string(REPLACE " " ";" deps_list "${deps}")
            set_property(TARGET ${_LIB_NAME} PROPERTY INTERFACE_LINK_LIBRARIES ${deps_list})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
    endforeach()
    unset(CONAN_FOUND_LIBRARY CACHE)
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()

macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()

macro(conan_set_std)
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
    if(CONAN_STD_CXX_FLAG)
        conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
        set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
    endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()

macro(conan_set_rpath)
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        set(CMAKE_SKIP_RPATH 1)  # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
                                 # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()

macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()

macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()

macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()

macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: 
"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}
"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}
"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])"
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})
function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${CONANINFO})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${CONANINFO})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()

function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL CONAN_COMPILER_VERSION)
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL CONAN_COMPILER_VERSION)
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()

function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()

macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()

macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()

macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()

macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

