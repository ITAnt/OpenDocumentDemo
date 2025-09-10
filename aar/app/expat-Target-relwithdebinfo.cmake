# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(expat_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(expat_FRAMEWORKS_FOUND_RELWITHDEBINFO "${expat_FRAMEWORKS_RELWITHDEBINFO}" "${expat_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(expat_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET expat_DEPS_TARGET)
    add_library(expat_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET expat_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${expat_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${expat_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### expat_DEPS_TARGET to all of them
conan_package_library_targets("${expat_LIBS_RELWITHDEBINFO}"    # libraries
                              "${expat_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${expat_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${expat_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${expat_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              expat_DEPS_TARGET
                              expat_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "expat"    # package_name
                              "${expat_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${expat_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${expat_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${expat_LIBRARIES_TARGETS}>
                 )

    if("${expat_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET expat::expat
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     expat_DEPS_TARGET)
    endif()

    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${expat_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${expat_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${expat_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${expat_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET expat::expat
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${expat_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(expat_LIBRARIES_RELWITHDEBINFO expat::expat)
