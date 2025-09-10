# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pdf2htmlex_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(pdf2htmlex_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pdf2htmlex_FRAMEWORKS_RELWITHDEBINFO}" "${pdf2htmlex_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(pdf2htmlex_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pdf2htmlex_DEPS_TARGET)
    add_library(pdf2htmlex_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pdf2htmlex_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:poppler::poppler;cairo::cairo;fontforge::fontforge;Freetype::Freetype;glib::glib>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pdf2htmlex_DEPS_TARGET to all of them
conan_package_library_targets("${pdf2htmlex_LIBS_RELWITHDEBINFO}"    # libraries
                              "${pdf2htmlex_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${pdf2htmlex_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pdf2htmlex_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pdf2htmlex_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pdf2htmlex_DEPS_TARGET
                              pdf2htmlex_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "pdf2htmlex"    # package_name
                              "${pdf2htmlex_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pdf2htmlex_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_LIBRARIES_TARGETS}>
                 )

    if("${pdf2htmlex_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET pdf2htmlex::pdf2htmlex
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     pdf2htmlex_DEPS_TARGET)
    endif()

    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET pdf2htmlex::pdf2htmlex
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${pdf2htmlex_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(pdf2htmlex_LIBRARIES_RELWITHDEBINFO pdf2htmlex::pdf2htmlex)
