# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(fontconfig_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(fontconfig_FRAMEWORKS_FOUND_RELWITHDEBINFO "${fontconfig_FRAMEWORKS_RELWITHDEBINFO}" "${fontconfig_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(fontconfig_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET fontconfig_DEPS_TARGET)
    add_library(fontconfig_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET fontconfig_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${fontconfig_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${fontconfig_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:EXPAT::EXPAT;Freetype::Freetype>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### fontconfig_DEPS_TARGET to all of them
conan_package_library_targets("${fontconfig_LIBS_RELWITHDEBINFO}"    # libraries
                              "${fontconfig_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${fontconfig_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${fontconfig_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${fontconfig_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              fontconfig_DEPS_TARGET
                              fontconfig_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "fontconfig"    # package_name
                              "${fontconfig_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${fontconfig_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_LIBRARIES_TARGETS}>
                 )

    if("${fontconfig_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET Fontconfig::Fontconfig
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     fontconfig_DEPS_TARGET)
    endif()

    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET Fontconfig::Fontconfig
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontconfig_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(fontconfig_LIBRARIES_RELWITHDEBINFO Fontconfig::Fontconfig)
