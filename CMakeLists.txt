cmake_minimum_required(VERSION 3.0)

#Avoid cmake from test compiling to host
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(mandel_service C CXX)
#check if conan is already run outside of project
if (NOT DEFINED CONAN_DEPENDENCIES)
  include(${CMAKE_CURRENT_BINARY_DIR}/conanbuildinfo.cmake OPTIONAL RESULT_VARIABLE HAS_CONAN)
  if (NOT HAS_CONAN)
    message(FATAL_ERROR "missing conanbuildinfo.cmake did you forget to run conan install ?")

  endif()
endif()
conan_basic_setup()

find_package(Protobuf REQUIRED)
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS mandel.proto)

include(os)

set(SOURCES
  service.cpp
)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
os_add_executable(mandel_service "Mandelbrot computation program" ${SOURCES} ${PROTO_SRCS} ${PROTO_HDRS})

# DRIVERS / PLUGINS:

if ("$ENV{PLATFORM}" STREQUAL "x86_solo5")
  os_add_drivers(mandel_service solo5net)
else()
  os_add_drivers(mandel_service
          virtionet     # Virtio networking
          vmxnet3
          boot_logger   # Display boot information
          # Use "boot --drivers ." to see other drivers
          # virtioblk # Virtio block device
          # ... Others from src/drivers
          )
endif()

os_add_stdout(mandel_service default_stdout)
os_add_plugins(mandel_service autoconf)
