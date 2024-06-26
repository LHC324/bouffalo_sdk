if(MINGW OR CYGWIN OR WIN32)
    set(WHERE_CMD where)
    set(TOOLCHAIN_SUFFIX ".exe")
elseif(UNIX OR APPLE)
    set(WHERE_CMD which)
    set(TOOLCHAIN_SUFFIX "")
endif()

find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
  message(STATUS "Enable ccache")
endif()

# specify cross compilers and tools
SET(CMAKE_C_COMPILER ${CROSS_COMPILE}gcc${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER ${CROSS_COMPILE}g++${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER ${CROSS_COMPILE}gcc${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_LINKER ${CROSS_COMPILE}ld${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_AR ${CROSS_COMPILE}ar${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_CREATE_STATIC_LIBRARY "<CMAKE_AR> crD <TARGET> <OBJECTS>")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> crD <TARGET> <OBJECTS>")
set(CMAKE_CXX_CREATE_STATIC_LIBRARY "<CMAKE_AR> crD <TARGET> <OBJECTS>")
set(CMAKE_RANLIB ${CROSS_COMPILE}ranlib${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJCOPY ${CROSS_COMPILE}objcopy CACHE INTERNAL "")
set(CMAKE_OBJDUMP ${CROSS_COMPILE}objdump CACHE INTERNAL "")
set(CMAKE_SIZE ${CROSS_COMPILE}size CACHE INTERNAL "")

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CMAKE_FIND_ROOT_PATH ${CROSS_COMPILE}gcc)
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
