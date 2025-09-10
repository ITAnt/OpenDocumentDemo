# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()
message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()

########## 'user_toolchain' block #############
# Include one or more CMake user toolchain from tools.cmake.cmaketoolchain:user_toolchain



########## 'generic_system' block #############
# Definition of system, platform and toolset





########## 'compilers' block #############



########## 'android_system' block #############
# Define Android variables ANDROID_PLATFORM, ANDROID_STL, ANDROID_ABI, etc
# and include(.../android.toolchain.cmake) from NDK toolchain file

# New Android toolchain definitions
message(STATUS "Conan toolchain: Setting Android platform: android-23")
set(ANDROID_PLATFORM android-23)
message(STATUS "Conan toolchain: Setting Android stl: c++_shared")
set(ANDROID_STL c++_shared)
message(STATUS "Conan toolchain: Setting Android abi: x86_64")
set(ANDROID_ABI x86_64)
include("@NDK_PATH@/build/cmake/android.toolchain.cmake")


########## 'libcxx' block #############
# Definition of libcxx from 'compiler.libcxx' setting, defining the
# right CXX_FLAGS for that libcxx



########## 'cppstd' block #############
# Define the C++ and C standards from 'compiler.cppstd' and 'compiler.cstd'

function(conan_modify_std_watch variable access value current_list_file stack)
    set(conan_watched_std_variable "20")
    if (${variable} STREQUAL "CMAKE_C_STANDARD")
        set(conan_watched_std_variable "")
    endif()
    if ("${access}" STREQUAL "MODIFIED_ACCESS" AND NOT "${value}" STREQUAL "${conan_watched_std_variable}")
        message(STATUS "Warning: Standard ${variable} value defined in conan_toolchain.cmake to ${conan_watched_std_variable} has been modified to ${value} by ${current_list_file}")
    endif()
    unset(conan_watched_std_variable)
endfunction()

message(STATUS "Conan toolchain: C++ Standard 20 with extensions OFF")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
variable_watch(CMAKE_CXX_STANDARD conan_modify_std_watch)


########## 'extra_flags' block #############
# Include extra C++, C and linker flags from configuration tools.build:<type>flags
# and from CMakeToolchain.extra_<type>_flags

# Conan conf flags start: 
# Conan conf flags end


########## 'cmake_flags_init' block #############
# Define CMAKE_<XXX>_FLAGS from CONAN_<XXX>_FLAGS

foreach(config IN LISTS CMAKE_CONFIGURATION_TYPES)
    string(TOUPPER ${config} config)
    if(DEFINED CONAN_CXX_FLAGS_${config})
      string(APPEND CMAKE_CXX_FLAGS_${config}_INIT " ${CONAN_CXX_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_C_FLAGS_${config})
      string(APPEND CMAKE_C_FLAGS_${config}_INIT " ${CONAN_C_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_SHARED_LINKER_FLAGS_${config})
      string(APPEND CMAKE_SHARED_LINKER_FLAGS_${config}_INIT " ${CONAN_SHARED_LINKER_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_EXE_LINKER_FLAGS_${config})
      string(APPEND CMAKE_EXE_LINKER_FLAGS_${config}_INIT " ${CONAN_EXE_LINKER_FLAGS_${config}}")
    endif()
endforeach()

if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_OBJCXX_FLAGS)
  string(APPEND CMAKE_OBJCXX_FLAGS_INIT " ${CONAN_OBJCXX_FLAGS}")
endif()
if(DEFINED CONAN_OBJC_FLAGS)
  string(APPEND CMAKE_OBJC_FLAGS_INIT " ${CONAN_OBJC_FLAGS}")
endif()


########## 'extra_variables' block #############
# Definition of extra CMake variables from tools.cmake.cmaketoolchain:extra_variables



########## 'try_compile' block #############
# Blocks after this one will not be added when running CMake try/checks
get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()


########## 'find_paths' block #############
# Define paths to find packages, programs, libraries, etc.
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/conan_cmakedeps_paths.cmake")
  message(STATUS "Conan toolchain: Including CMakeDeps generated conan_cmakedeps_paths.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/conan_cmakedeps_paths.cmake")
else()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
list(PREPEND CMAKE_MODULE_PATH "C:/Users/PC/.conan2/p/openjac318085f8aef/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "C:/Users/PC/.conan2/p/openjac318085f8aef/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "C:/Users/PC/.conan2/p/odrco83ed2e47db1bd/p/lib" "C:/Users/PC/.conan2/p/pugix4e8c5a6c7125f/p/lib" "C:/Users/PC/.conan2/p/cryptad32fe7cd0b1a/p/lib" "C:/Users/PC/.conan2/p/miniz6d66b398db6f0/p/lib" "C:/Users/PC/.conan2/p/uchar2d61fd4207811/p/lib" "C:/Users/PC/.conan2/p/pdf2h86c1174c68f88/p/lib" "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p/lib" "C:/Users/PC/.conan2/p/openjac318085f8aef/p/lib" "C:/Users/PC/.conan2/p/lcmsffe25f3f5cf59/p/lib" "C:/Users/PC/.conan2/p/cairo69b876718fff9/p/lib" "C:/Users/PC/.conan2/p/pixmac7396c96fcd17/p/lib" "C:/Users/PC/.conan2/p/lzo2ae9223db79ac/p/lib" "C:/Users/PC/.conan2/p/fontc6c455df2369b3/p/lib" "C:/Users/PC/.conan2/p/expat5d5b36794b388/p/lib" "C:/Users/PC/.conan2/p/fontf001ebf16477bd/p/lib" "C:/Users/PC/.conan2/p/freet7dce30446c55d/p/lib" "C:/Users/PC/.conan2/p/brotlf9e128dd7f347/p/lib" "C:/Users/PC/.conan2/p/giflieaccfd1e3326f/p/lib" "C:/Users/PC/.conan2/p/libjp24a4974036424/p/lib" "C:/Users/PC/.conan2/p/wvwarb2f91e9c30400/p/lib" "C:/Users/PC/.conan2/p/libgsfe73a1a172264/p/lib" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/lib" "C:/Users/PC/.conan2/p/libff92ebfff1bf74e/p/lib" "C:/Users/PC/.conan2/p/pcre212ff88f62bfae/p/lib" "C:/Users/PC/.conan2/p/bzip2279ba01e7f371/p/lib" "C:/Users/PC/.conan2/p/libel3ef084d02c0dc/p/lib" "C:/Users/PC/.conan2/p/libge6884e292e2fe4/p/lib" "C:/Users/PC/.conan2/p/libpnf27a3aae24024/p/lib" "C:/Users/PC/.conan2/p/libxm4fab285d00e98/p/lib" "C:/Users/PC/.conan2/p/zlib8a14b7018e8c5/p/lib" "C:/Users/PC/.conan2/p/libic7912cbbd0f232/p/lib" "C:/Users/PC/.conan2/p/argonad6abc2338828/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "C:/Users/PC/.conan2/p/odrco83ed2e47db1bd/p/include" "C:/Users/PC/.conan2/p/pugix4e8c5a6c7125f/p/include" "C:/Users/PC/.conan2/p/cryptad32fe7cd0b1a/p/include" "C:/Users/PC/.conan2/p/miniz6d66b398db6f0/p/include" "C:/Users/PC/.conan2/p/miniz6d66b398db6f0/p/include/miniz" "C:/Users/PC/.conan2/p/nlohm0567ffc90cfc1/p/include" "C:/Users/PC/.conan2/p/vince1155fcbbb4bff/p/include" "C:/Users/PC/.conan2/p/uchar2d61fd4207811/p/include" "C:/Users/PC/.conan2/p/utfcpfe50a28798901/p/include" "C:/Users/PC/.conan2/p/utfcpfe50a28798901/p/include/utf8cpp" "C:/Users/PC/.conan2/p/pdf2h86c1174c68f88/p/include" "C:/Users/PC/.conan2/p/pdf2h86c1174c68f88/p/include/pdf2htmlEX" "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p/include" "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p/include/poppler/cpp" "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p/include/poppler" "C:/Users/PC/.conan2/p/openjac318085f8aef/p/include" "C:/Users/PC/.conan2/p/openjac318085f8aef/p/include/openjpeg-2.5" "C:/Users/PC/.conan2/p/lcmsffe25f3f5cf59/p/include" "C:/Users/PC/.conan2/p/boost45e32a7fe50b6/p/include" "C:/Users/PC/.conan2/p/cairo69b876718fff9/p/include" "C:/Users/PC/.conan2/p/cairo69b876718fff9/p/include/cairo" "C:/Users/PC/.conan2/p/pixmac7396c96fcd17/p/include" "C:/Users/PC/.conan2/p/pixmac7396c96fcd17/p/include/pixman-1" "C:/Users/PC/.conan2/p/lzo2ae9223db79ac/p/include" "C:/Users/PC/.conan2/p/lzo2ae9223db79ac/p/include/lzo" "C:/Users/PC/.conan2/p/fontc6c455df2369b3/p/include" "C:/Users/PC/.conan2/p/expat5d5b36794b388/p/include" "C:/Users/PC/.conan2/p/fontf001ebf16477bd/p/include" "C:/Users/PC/.conan2/p/fontf001ebf16477bd/p/include/fontforge" "C:/Users/PC/.conan2/p/freet7dce30446c55d/p/include" "C:/Users/PC/.conan2/p/freet7dce30446c55d/p/include/freetype2" "C:/Users/PC/.conan2/p/brotlf9e128dd7f347/p/include" "C:/Users/PC/.conan2/p/giflieaccfd1e3326f/p/include" "C:/Users/PC/.conan2/p/libjp24a4974036424/p/include" "C:/Users/PC/.conan2/p/wvwarb2f91e9c30400/p/include" "C:/Users/PC/.conan2/p/libgsfe73a1a172264/p/include/libgsf-1" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/include/gio-unix-2.0" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/include" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/include/glib-2.0" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/lib/glib-2.0/include" "C:/Users/PC/.conan2/p/libff92ebfff1bf74e/p/include" "C:/Users/PC/.conan2/p/pcre212ff88f62bfae/p/include" "C:/Users/PC/.conan2/p/bzip2279ba01e7f371/p/include" "C:/Users/PC/.conan2/p/libel3ef084d02c0dc/p/include" "C:/Users/PC/.conan2/p/libel3ef084d02c0dc/p/include/libelf" "C:/Users/PC/.conan2/p/libge6884e292e2fe4/p/include" "C:/Users/PC/.conan2/p/libpnf27a3aae24024/p/include" "C:/Users/PC/.conan2/p/libxm4fab285d00e98/p/include" "C:/Users/PC/.conan2/p/libxm4fab285d00e98/p/include/libxml2" "C:/Users/PC/.conan2/p/zlib8a14b7018e8c5/p/include" "C:/Users/PC/.conan2/p/libic7912cbbd0f232/p/include" "C:/Users/PC/.conan2/p/cpp-h03d204942caf5/p/include" "C:/Users/PC/.conan2/p/cpp-h03d204942caf5/p/include/httplib" "C:/Users/PC/.conan2/p/argonad6abc2338828/p/include")
set(CONAN_RUNTIME_LIB_DIRS "C:/Users/PC/.conan2/p/odrco83ed2e47db1bd/p/lib" "C:/Users/PC/.conan2/p/pugix4e8c5a6c7125f/p/lib" "C:/Users/PC/.conan2/p/cryptad32fe7cd0b1a/p/lib" "C:/Users/PC/.conan2/p/miniz6d66b398db6f0/p/lib" "C:/Users/PC/.conan2/p/uchar2d61fd4207811/p/lib" "C:/Users/PC/.conan2/p/pdf2h86c1174c68f88/p/lib" "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p/lib" "C:/Users/PC/.conan2/p/openjac318085f8aef/p/lib" "C:/Users/PC/.conan2/p/lcmsffe25f3f5cf59/p/lib" "C:/Users/PC/.conan2/p/cairo69b876718fff9/p/lib" "C:/Users/PC/.conan2/p/pixmac7396c96fcd17/p/lib" "C:/Users/PC/.conan2/p/lzo2ae9223db79ac/p/lib" "C:/Users/PC/.conan2/p/fontc6c455df2369b3/p/lib" "C:/Users/PC/.conan2/p/expat5d5b36794b388/p/lib" "C:/Users/PC/.conan2/p/fontf001ebf16477bd/p/lib" "C:/Users/PC/.conan2/p/freet7dce30446c55d/p/lib" "C:/Users/PC/.conan2/p/brotlf9e128dd7f347/p/lib" "C:/Users/PC/.conan2/p/giflieaccfd1e3326f/p/lib" "C:/Users/PC/.conan2/p/libjp24a4974036424/p/lib" "C:/Users/PC/.conan2/p/wvwarb2f91e9c30400/p/lib" "C:/Users/PC/.conan2/p/libgsfe73a1a172264/p/lib" "C:/Users/PC/.conan2/p/glib29cde58b8fcae/p/lib" "C:/Users/PC/.conan2/p/libff92ebfff1bf74e/p/lib" "C:/Users/PC/.conan2/p/pcre212ff88f62bfae/p/lib" "C:/Users/PC/.conan2/p/bzip2279ba01e7f371/p/lib" "C:/Users/PC/.conan2/p/libel3ef084d02c0dc/p/lib" "C:/Users/PC/.conan2/p/libge6884e292e2fe4/p/lib" "C:/Users/PC/.conan2/p/libpnf27a3aae24024/p/lib" "C:/Users/PC/.conan2/p/libxm4fab285d00e98/p/lib" "C:/Users/PC/.conan2/p/zlib8a14b7018e8c5/p/lib" "C:/Users/PC/.conan2/p/libic7912cbbd0f232/p/lib" "C:/Users/PC/.conan2/p/argonad6abc2338828/p/lib" )

if(NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_PACKAGE OR CMAKE_FIND_ROOT_PATH_MODE_PACKAGE STREQUAL "ONLY")
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE "BOTH")
endif()
if(NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_PROGRAM OR CMAKE_FIND_ROOT_PATH_MODE_PROGRAM STREQUAL "ONLY")
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM "BOTH")
endif()
if(NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_LIBRARY OR CMAKE_FIND_ROOT_PATH_MODE_LIBRARY STREQUAL "ONLY")
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY "BOTH")
endif()
if(NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_INCLUDE OR CMAKE_FIND_ROOT_PATH_MODE_INCLUDE STREQUAL "ONLY")
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE "BOTH")
endif()
endif()


########## 'pkg_config' block #############
# Define pkg-config from 'tools.gnu:pkg_config' executable and paths

if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR};$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR};")
endif()


########## 'rpath' block #############
# Defining CMAKE_SKIP_RPATH



########## 'output_dirs' block #############
# Definition of CMAKE_INSTALL_XXX folders

set(CMAKE_INSTALL_BINDIR "bin")
set(CMAKE_INSTALL_SBINDIR "bin")
set(CMAKE_INSTALL_LIBEXECDIR "bin")
set(CMAKE_INSTALL_LIBDIR "lib")
set(CMAKE_INSTALL_INCLUDEDIR "include")
set(CMAKE_INSTALL_OLDINCLUDEDIR "include")


########## 'variables' block #############
# Definition of CMake variables from CMakeToolchain.variables values

# Variables
# Variables  per configuration



########## 'preprocessor' block #############
# Preprocessor definitions from CMakeToolchain.preprocessor_definitions values

# Preprocessor definitions per configuration



if(CMAKE_POLICY_DEFAULT_CMP0091)  # Avoid unused and not-initialized warnings
endif()
