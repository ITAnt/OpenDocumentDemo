# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libjpeg_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(libjpeg_FRAMEWORKS_FOUND_RELWITHDEBINFO "${libjpeg_FRAMEWORKS_RELWITHDEBINFO}" "${libjpeg_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(libjpeg_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libjpeg_DEPS_TARGET)
    add_library(libjpeg_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libjpeg_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${libjpeg_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${libjpeg_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libjpeg_DEPS_TARGET to all of them
conan_package_library_targets("${libjpeg_LIBS_RELWITHDEBINFO}"    # libraries
                              "${libjpeg_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${libjpeg_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${libjpeg_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${libjpeg_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              libjpeg_DEPS_TARGET
                              libjpeg_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "libjpeg"    # package_name
                              "${libjpeg_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libjpeg_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_LIBRARIES_TARGETS}>
                 )

    if("${libjpeg_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET JPEG::JPEG
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libjpeg_DEPS_TARGET)
    endif()

    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET JPEG::JPEG
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libjpeg_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(libjpeg_LIBRARIES_RELWITHDEBINFO JPEG::JPEG)
