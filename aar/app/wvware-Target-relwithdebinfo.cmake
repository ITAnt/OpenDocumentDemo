# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(wvware_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(wvware_FRAMEWORKS_FOUND_RELWITHDEBINFO "${wvware_FRAMEWORKS_RELWITHDEBINFO}" "${wvware_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(wvware_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET wvware_DEPS_TARGET)
    add_library(wvware_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET wvware_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${wvware_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${wvware_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:libgsf::libgsf;glib::glib;PNG::PNG;LibXml2::LibXml2;ZLIB::ZLIB;Iconv::Iconv>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### wvware_DEPS_TARGET to all of them
conan_package_library_targets("${wvware_LIBS_RELWITHDEBINFO}"    # libraries
                              "${wvware_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${wvware_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${wvware_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${wvware_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              wvware_DEPS_TARGET
                              wvware_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "wvware"    # package_name
                              "${wvware_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${wvware_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${wvware_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${wvware_LIBRARIES_TARGETS}>
                 )

    if("${wvware_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET wvware::wvware
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     wvware_DEPS_TARGET)
    endif()

    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${wvware_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${wvware_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${wvware_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${wvware_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET wvware::wvware
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${wvware_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(wvware_LIBRARIES_RELWITHDEBINFO wvware::wvware)
