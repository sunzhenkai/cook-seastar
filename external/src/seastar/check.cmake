get_filename_component(_DEP_NAME ${CMAKE_CURRENT_LIST_DIR} NAME)

message(STATUS "dependency: ${_DEP_NAME}, version: ${SEASTAR_VERSION}")

unset(_DEP_NAME)