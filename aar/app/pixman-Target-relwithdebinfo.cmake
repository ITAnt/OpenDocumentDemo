# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pixman_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(pixman_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pixman_FRAMEWORKS_RELWITHDEBINFO}" "${pixman_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(pixman_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pixman_DEPS_TARGET)
    add_library(pixman_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pixman_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${pixman_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${pixman_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pixman_DEPS_TARGET to all of them
conan_package_library_targets("${pixman_LIBS_RELWITHDEBINFO}"    # libraries
                              "${pixman_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${pixman_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pixman_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pixman_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pixman_DEPS_TARGET
                              pixman_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "pixman"    # package_name
                              "${pixman_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pixman_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${pixman_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${pixman_LIBRARIES_TARGETS}>
                 )

    if("${pixman_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET pixman::pixman
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     pixman_DEPS_TARGET)
    endif()

    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${pixman_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${pixman_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${pixman_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${pixman_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET pixman::pixman
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${pixman_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(pixman_LIBRARIES_RELWITHDEBINFO pixman::pixman)
