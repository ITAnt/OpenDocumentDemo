# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libgsf_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(libgsf_FRAMEWORKS_FOUND_RELWITHDEBINFO "${libgsf_FRAMEWORKS_RELWITHDEBINFO}" "${libgsf_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(libgsf_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libgsf_DEPS_TARGET)
    add_library(libgsf_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libgsf_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${libgsf_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${libgsf_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:glib::glib;LibXml2::LibXml2;ZLIB::ZLIB>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libgsf_DEPS_TARGET to all of them
conan_package_library_targets("${libgsf_LIBS_RELWITHDEBINFO}"    # libraries
                              "${libgsf_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${libgsf_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${libgsf_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${libgsf_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              libgsf_DEPS_TARGET
                              libgsf_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "libgsf"    # package_name
                              "${libgsf_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libgsf_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_LIBRARIES_TARGETS}>
                 )

    if("${libgsf_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libgsf::libgsf
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     libgsf_DEPS_TARGET)
    endif()

    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET libgsf::libgsf
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${libgsf_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(libgsf_LIBRARIES_RELWITHDEBINFO libgsf::libgsf)
