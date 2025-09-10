# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(fontforge_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(fontforge_FRAMEWORKS_FOUND_RELWITHDEBINFO "${fontforge_FRAMEWORKS_RELWITHDEBINFO}" "${fontforge_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(fontforge_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET fontforge_DEPS_TARGET)
    add_library(fontforge_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET fontforge_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${fontforge_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${fontforge_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:Freetype::Freetype;GIF::GIF;JPEG::JPEG;glib::glib;Intl::Intl;PNG::PNG;LibXml2::LibXml2>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### fontforge_DEPS_TARGET to all of them
conan_package_library_targets("${fontforge_LIBS_RELWITHDEBINFO}"    # libraries
                              "${fontforge_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${fontforge_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${fontforge_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${fontforge_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              fontforge_DEPS_TARGET
                              fontforge_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "fontforge"    # package_name
                              "${fontforge_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${fontforge_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_LIBRARIES_TARGETS}>
                 )

    if("${fontforge_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET fontforge::fontforge
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     fontforge_DEPS_TARGET)
    endif()

    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET fontforge::fontforge
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${fontforge_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(fontforge_LIBRARIES_RELWITHDEBINFO fontforge::fontforge)
