cmake_minimum_required(VERSION 3.10)
project(cook-seastar)

# versions
SET(SEASTAR_VERSION 20.05.0)

# set symbols
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "-std=gnu++17 -O3 -fPIC -fno-omit-frame-pointer -Wno-sign-compare -pthread")

set(SRC_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include)

add_definitions(-Wall -g)

message(STATUS "SRC_INCLUDE_DIR = ${SRC_INCLUDE_DIR}")
message(STATUS "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")

# includes
include(${CMAKE_CURRENT_LIST_DIR}/external/utils.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/external/fmt/check.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/external/boost/check.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/external/seastar/check.cmake)

include_directories(${SRC_INCLUDE_DIR})

file(GLOB SOURCE_FILES src/*.cpp)
set(EXTRA_LIB Seastar::seastar fmt::fmt)

# executables
add_executable(hello src/sample/hello.cpp)

add_executable(fmt src/sample/fmt.cpp)
target_link_libraries(fmt fmt::fmt)

add_executable(boost src/sample/boost.cpp)
target_link_libraries(boost)

add_executable(sample src/tutorial/sample.cpp)
target_link_libraries(sample ${EXTRA_LIB})

add_executable(smp src/tutorial/smp.cpp)
target_link_libraries(smp ${EXTRA_LIB})