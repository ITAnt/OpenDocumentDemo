# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libpng_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(libpng_FRAMEWORKS_FOUND_RELWITHDEBINFO "${libpng_FRAMEWORKS_RELWITHDEBINFO}" "${libpng_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(libpng_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libpng_DEPS_TARGET)
    add_library(libpng_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libpng_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${libpng_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${libpng_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:ZLIB::ZLIB>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libpng_DEPS_TARGET to all of them
conan_package_library_targets("${libpng_LIBS_RELWITHDEBINFO}"    # libraries
                              "${libpng_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${libpng_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${libpng_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${libpng_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              libpng_DEPS_TARGET
                              libpng_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "libpng"    # package_name
                              "${libpng_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libpng_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${libpng_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${libpng_LIBRARIES_TARGETS}>
                 )

    if("${libpng_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET PNG::PNG
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libpng_DEPS_TARGET)
    endif()

    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libpng_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libpng_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libpng_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${libpng_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET PNG::PNG
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libpng_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(libpng_LIBRARIES_RELWITHDEBINFO PNG::PNG)
