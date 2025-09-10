# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libffi_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(libffi_FRAMEWORKS_FOUND_RELWITHDEBINFO "${libffi_FRAMEWORKS_RELWITHDEBINFO}" "${libffi_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(libffi_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libffi_DEPS_TARGET)
    add_library(libffi_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libffi_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${libffi_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${libffi_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libffi_DEPS_TARGET to all of them
conan_package_library_targets("${libffi_LIBS_RELWITHDEBINFO}"    # libraries
                              "${libffi_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${libffi_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${libffi_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${libffi_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              libffi_DEPS_TARGET
                              libffi_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "libffi"    # package_name
                              "${libffi_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libffi_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${libffi_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${libffi_LIBRARIES_TARGETS}>
                 )

    if("${libffi_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libffi::libffi
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libffi_DEPS_TARGET)
    endif()

    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libffi_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libffi_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libffi_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${libffi_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET libffi::libffi
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libffi_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(libffi_LIBRARIES_RELWITHDEBINFO libffi::libffi)
