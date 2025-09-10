# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libiconv_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(libiconv_FRAMEWORKS_FOUND_RELWITHDEBINFO "${libiconv_FRAMEWORKS_RELWITHDEBINFO}" "${libiconv_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(libiconv_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libiconv_DEPS_TARGET)
    add_library(libiconv_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libiconv_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${libiconv_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${libiconv_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libiconv_DEPS_TARGET to all of them
conan_package_library_targets("${libiconv_LIBS_RELWITHDEBINFO}"    # libraries
                              "${libiconv_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${libiconv_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${libiconv_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${libiconv_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              libiconv_DEPS_TARGET
                              libiconv_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "libiconv"    # package_name
                              "${libiconv_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libiconv_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_LIBRARIES_TARGETS}>
                 )

    if("${libiconv_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET Iconv::Iconv
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libiconv_DEPS_TARGET)
    endif()

    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET Iconv::Iconv
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libiconv_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(libiconv_LIBRARIES_RELWITHDEBINFO Iconv::Iconv)
