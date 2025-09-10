# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(lcms_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(lcms_FRAMEWORKS_FOUND_RELWITHDEBINFO "${lcms_FRAMEWORKS_RELWITHDEBINFO}" "${lcms_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(lcms_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET lcms_DEPS_TARGET)
    add_library(lcms_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET lcms_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${lcms_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${lcms_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### lcms_DEPS_TARGET to all of them
conan_package_library_targets("${lcms_LIBS_RELWITHDEBINFO}"    # libraries
                              "${lcms_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${lcms_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${lcms_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${lcms_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              lcms_DEPS_TARGET
                              lcms_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "lcms"    # package_name
                              "${lcms_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${lcms_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${lcms_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${lcms_LIBRARIES_TARGETS}>
                 )

    if("${lcms_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET lcms::lcms
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     lcms_DEPS_TARGET)
    endif()

    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${lcms_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${lcms_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${lcms_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${lcms_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET lcms::lcms
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${lcms_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(lcms_LIBRARIES_RELWITHDEBINFO lcms::lcms)
