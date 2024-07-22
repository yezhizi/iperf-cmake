cmake_minimum_required(VERSION 3.9)
project(iperf VERSION 3.6)

include(cmake/configure.cmake)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/iperf_config.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/iperf_config.h @ONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/version.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/version.h @ONLY)
include_directories(${CMAKE_CURRENT_BINARY_DIR}/)

list(APPEND LIBIPERF_SRCS
    iperf/src/cjson.c iperf/src/dscp.c iperf/src/iperf_api.c iperf/src/iperf_auth.c
    iperf/src/iperf_client_api.c iperf/src/iperf_error.c iperf/src/iperf_locale.c
    iperf/src/iperf_sctp.c iperf/src/iperf_server_api.c iperf/src/iperf_tcp.c
    iperf/src/iperf_time.c iperf/src/iperf_udp.c iperf/src/iperf_util.c iperf/src/net.c
    iperf/src/t_api.c iperf/src/t_timer.c iperf/src/t_units.c iperf/src/t_uuid.c
    iperf/src/tcp_info.c iperf/src/timer.c iperf/src/units.c
    )
list(APPEND LIBIPERF_HDRS iperf/src/iperf_api.h)

find_package(Threads REQUIRED) # Find the threads library
find_package(OpenSSL REQUIRED) # Find the OpenSSL library

add_library(${PROJECT_NAME} STATIC ${LIBIPERF_SRCS})
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER ${LIBIPERF_HDRS})

target_link_libraries(${PROJECT_NAME} PRIVATE OpenSSL::SSL m OpenSSL::Crypto Threads::Threads)

add_executable(iperf3 iperf/src/main.c)
target_link_libraries(iperf3 ${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME}
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include)

install(TARGETS iperf3 RUNTIME DESTINATION bin)

