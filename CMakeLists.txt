cmake_minimum_required(VERSION 3.10)
project(cook-seastar)

# set symbols
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")

set(DEPS_DIR ${CMAKE_SOURCE_DIR}/external/deps)
set(DEPS_LIB_DIR ${DEPS_DIR}/lib)
set(DEPS_INCLUDE_DIR ${DEPS_DIR}/include)
set(SRC_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include)

message(STATUS "DEPS_DIR = " ${DEPS_DIR})
message(STATUS "DEPS_INCLUDE_DIR = " ${DEPS_INCLUDE_DIR})
message(STATUS "SRC_INCLUDE_DIR = " ${SRC_INCLUDE_DIR})

# includes
include_directories(${DEPS_INCLUDE_DIR})
include_directories(${SRC_INCLUDE_DIR})

# find libraries
find_library(PROTO_BUFFER protobuf ${DEPS_LIB_DIR} NO_DEFAULT_PATH)
find_library(PROTO_LITE protobuf-lite ${DEPS_LIB_DIR} NO_DEFAULT_PATH)
find_library(PROTOC protoc ${DEPS_LIB_DIR} NO_DEFAULT_PATH)
find_library(BOOST_SYSTEM boost_system ${DEPS_LIB_DIR} NO_DEFAULT_PATH)
find_library(SEASTAR libseastar.a ${DEPS_LIB_DIR} NO_DEFAULT_PATH)

set(CMAKE_CXX_FLAGS "-std=c++17 -g -O3 -w -fPIC -fno-omit-frame-pointer -Wno-sign-compare -pthread")
set(EXTERNAL_LIB ${BOOST_SYSTEM} ${PROTO_BUFFER} ${PROTO_LITE} ${PROTOC})
file(GLOB SOURCE_FILES src/*.cpp)
#add_library(service-lib STATIC ${SOURCE_FILES})

# executables
add_executable(hello src/sample/hello.cpp)

add_executable(boost src/sample/boost.cpp)
target_link_libraries(boost ${EXTERNAL_LIB})

add_executable(sample src/tutorial/sample.cpp)
target_link_libraries(sample ${EXTERNAL_LIB})

#add_executable(smp src/tutorial/smp.cpp)
#target_link_libraries(smp ${EXTERNAL_LIB} -v)