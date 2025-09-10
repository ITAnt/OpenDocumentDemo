# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(giflib_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(giflib_FRAMEWORKS_FOUND_RELWITHDEBINFO "${giflib_FRAMEWORKS_RELWITHDEBINFO}" "${giflib_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(giflib_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET giflib_DEPS_TARGET)
    add_library(giflib_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET giflib_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${giflib_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${giflib_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### giflib_DEPS_TARGET to all of them
conan_package_library_targets("${giflib_LIBS_RELWITHDEBINFO}"    # libraries
                              "${giflib_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${giflib_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${giflib_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${giflib_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              giflib_DEPS_TARGET
                              giflib_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "giflib"    # package_name
                              "${giflib_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${giflib_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${giflib_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${giflib_LIBRARIES_TARGETS}>
                 )

    if("${giflib_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET GIF::GIF
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     giflib_DEPS_TARGET)
    endif()

    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${giflib_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${giflib_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${giflib_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${giflib_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET GIF::GIF
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${giflib_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(giflib_LIBRARIES_RELWITHDEBINFO GIF::GIF)
