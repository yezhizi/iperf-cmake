include(CheckIncludeFile)
include(CheckFunctionExists)
include(CheckCSourceCompiles)
include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckTypeSize)

check_function_exists(cpuset_setaffinity HAVE_CPUSET_SETAFFINITY)
check_function_exists(sched_setaffinity HAVE_SCHED_SETAFFINITY)
check_function_exists(SetProcessAffinityMask HAVE_SETPROCESSAFFINITYMASK)
if (HAVE_CPUSET_SETAFFINITY OR HAVE_SCHED_SETAFFINITY OR HAVE_SETPROCESSAFFINITYMASK)
    message(STATUS "Have CPU affinity support - found")
    set(HAVE_CPU_AFFINITY 1 CACHE INTERNAL "CPU affinity support")
else ()
    message(STATUS "Have CPU affinity support - not found")
    set(HAVE_CPU_AFFINITY 0 CACHE INTERNAL "CPU affinity support")
endif ()

check_function_exists(clock_gettime HAVE_CLOCK_GETTIME)
check_function_exists(daemon HAVE_DAEMON)
check_function_exists(getline HAVE_GETLINE)
check_function_exists(sendfile HAVE_SENDFILE)

check_include_file(dlfcn.h HAVE_DLFCN_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(strings.h HAVE_STRINGS_H)
if (HAVE_DLFCN_H AND HAVE_INTTYPES_H AND HAVE_MEMORY_H AND HAVE_STDINT_H AND HAVE_STDLIB_H AND HAVE_STRING_H AND HAVE_STRINGS_H)
    message(STATUS "ANSI C header files - found")
    set(STDC_HEADERS 1 CACHE INTERNAL "ANSI C header files")
else ()
    message(STATUS "ANSI C header files - not found")
    set(STDC_HEADERS 0 CACHE INTERNAL "ANSI C header files")
endif ()

check_include_file(poll.h HAVE_POLL_H)
check_include_file(endian.h HAVE_ENDIAN_H)
check_include_file("sys/endian.h" HAVE_SYS_ENDIAN_H)
check_include_file("sys/socket.h" HAVE_SYS_SOCKET_H)
check_include_file("sys/stat.h" HAVE_SYS_STAT_H)
check_include_file("sys/types.h" HAVE_SYS_TYPES_H)
check_include_file("pthread.h" HAVE_PTHREAD)
check_include_file(unistd.h HAVE_UNISTD_H)

check_symbol_exists(IPV6_FLOWLABEL_MGR "linux/in6.h" HAVE_FLOWLABEL)
check_symbol_exists(SO_MAX_PACING_RATE "sys/socket.h" HAVE_SO_MAX_PACING_RATE)
check_symbol_exists(TCP_CONGESTION "sys/socket.h" HAVE_TCP_CONGESTION)

check_c_source_compiles("
int main(void) {
    const int a = 0;
    return 0;
}" HAVE_CONST)

check_include_file("netinet/sctp.h" HAVE_NETINET_SCTP_H)
check_type_size("struct sctp_assoc_value" HAVE_STRUCT_SCTP_ASSOC_VALUE)
if (HAVE_NETINET_SCTP_H AND HAVE_STRUCT_SCTP_ASSOC_VALUE)
    message(STATUS "Have SCTP support - found")
    set(HAVE_SCTP 1 CACHE INTERNAL "SCTP support")
else ()
    message(STATUS "Have SCTP support - not found")
    set(HAVE_SCTP 0 CACHE INTERNAL "SCTP support")
endif ()

check_include_file("openssl/bio.h" HAVE_SSL_HDR)
check_library_exists(crypto BIO_s_mem "" HAVE_CRYPTO_LIB)
if (HAVE_SSL_HDR AND HAVE_CRYPTO_LIB)
    message(STATUS "Have SSL - found")
    set(HAVE_SSL 1 CACHE INTERNAL "SSL Library")
else ()
    message(STATUS "Have SSL - not found")
    set(HAVE_SSL 0 CACHE INTERNAL "SSL Library")
endif ()

set(PKG "iperf" CACHE INTERNAL "Package")
set(PKG_NAME "iperf" CACHE INTERNAL "Package name")
set(PKG_TARNAME "${PKG_NAME}" CACHE INTERNAL "Package tarname")
set(PKG_VERSION "3.6+")
set(PKG_STRING "${PKG_NAME} ${PKG_VERSION}")
set(PKG_URL "https://software.es.net/iperf/" CACHE INTERNAL "Package URL")
set(PKG_BUGREPORT "https://github.com/esnet/iperf" CACHE INTERNAL "Packaage bug report")

