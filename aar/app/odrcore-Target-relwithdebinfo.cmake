# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(odrcore_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(odrcore_FRAMEWORKS_FOUND_RELWITHDEBINFO "${odrcore_FRAMEWORKS_RELWITHDEBINFO}" "${odrcore_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(odrcore_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET odrcore_DEPS_TARGET)
    add_library(odrcore_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET odrcore_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${odrcore_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${odrcore_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:pugixml::pugixml;cryptopp::cryptopp;miniz::miniz;uchardet::uchardet;pdf2htmlex::pdf2htmlex;wvware::wvware;argon2::argon2>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### odrcore_DEPS_TARGET to all of them
conan_package_library_targets("${odrcore_LIBS_RELWITHDEBINFO}"    # libraries
                              "${odrcore_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${odrcore_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${odrcore_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${odrcore_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              odrcore_DEPS_TARGET
                              odrcore_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "odrcore"    # package_name
                              "${odrcore_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${odrcore_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES RelWithDebInfo ########################################
    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_OBJECTS_RELWITHDEBINFO}>
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_LIBRARIES_TARGETS}>
                 )

    if("${odrcore_LIBS_RELWITHDEBINFO}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET odrcore::odrcore
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     odrcore_DEPS_TARGET)
    endif()

    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_LINKER_FLAGS_RELWITHDEBINFO}>)
    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_INCLUDE_DIRS_RELWITHDEBINFO}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_LIB_DIRS_RELWITHDEBINFO}>)
    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
    set_property(TARGET odrcore::odrcore
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:RelWithDebInfo>:${odrcore_COMPILE_OPTIONS_RELWITHDEBINFO}>)

########## For the modules (FindXXX)
set(odrcore_LIBRARIES_RELWITHDEBINFO odrcore::odrcore)
