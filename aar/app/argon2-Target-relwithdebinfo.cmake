# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(argon2_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(argon2_FRAMEWORKS_FOUND_RELWITHDEBINFO "${argon2_FRAMEWORKS_RELWITHDEBINFO}" "${argon2_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(argon2_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET argon2_DEPS_TARGET)
    add_library(argon2_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET argon2_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${argon2_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${argon2_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### argon2_DEPS_TARGET to all of them
conan_package_library_targets("${argon2_LIBS_RELWITHDEBINFO}"    # libraries
                              "${argon2_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${argon2_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${argon2_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${argon2_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              argon2_DEPS_TARGET
                              argon2_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "argon2"    # package_name
                              "${argon2_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${argon2_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${argon2_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${argon2_LIBRARIES_TARGETS}>
                 )

    if("${argon2_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET argon2::argon2
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     argon2_DEPS_TARGET)
    endif()

    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${argon2_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${argon2_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${argon2_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${argon2_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET argon2::argon2
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${argon2_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(argon2_LIBRARIES_RELWITHDEBINFO argon2::argon2)
