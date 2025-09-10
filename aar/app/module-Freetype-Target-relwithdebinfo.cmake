# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(freetype_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(freetype_FRAMEWORKS_FOUND_RELWITHDEBINFO "${freetype_FRAMEWORKS_RELWITHDEBINFO}" "${freetype_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(freetype_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET freetype_DEPS_TARGET)
    add_library(freetype_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET freetype_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${freetype_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${freetype_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:brotli::brotli;BZip2::BZip2;PNG::PNG;ZLIB::ZLIB>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### freetype_DEPS_TARGET to all of them
conan_package_library_targets("${freetype_LIBS_RELWITHDEBINFO}"    # libraries
                              "${freetype_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${freetype_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${freetype_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${freetype_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              freetype_DEPS_TARGET
                              freetype_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "freetype"    # package_name
                              "${freetype_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${freetype_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${freetype_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${freetype_LIBRARIES_TARGETS}>
                 )

    if("${freetype_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET Freetype::Freetype
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     freetype_DEPS_TARGET)
    endif()

    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${freetype_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${freetype_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${freetype_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${freetype_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET Freetype::Freetype
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${freetype_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(freetype_LIBRARIES_RELWITHDEBINFO Freetype::Freetype)
