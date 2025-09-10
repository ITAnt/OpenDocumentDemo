# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(poppler-data_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(poppler-data_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler-data_FRAMEWORKS_RELWITHDEBINFO}" "${poppler-data_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(poppler-data_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET poppler-data_DEPS_TARGET)
    add_library(poppler-data_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET poppler-data_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${poppler-data_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${poppler-data_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### poppler-data_DEPS_TARGET to all of them
conan_package_library_targets("${poppler-data_LIBS_RELWITHDEBINFO}"    # libraries
                              "${poppler-data_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${poppler-data_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler-data_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler-data_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler-data_DEPS_TARGET
                              poppler-data_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "poppler-data"    # package_name
                              "${poppler-data_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${poppler-data_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_LIBRARIES_TARGETS}>
                 )

    if("${poppler-data_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET poppler-data::poppler-data
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     poppler-data_DEPS_TARGET)
    endif()

    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET poppler-data::poppler-data
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${poppler-data_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(poppler-data_LIBRARIES_RELWITHDEBINFO poppler-data::poppler-data)
