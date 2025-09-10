# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pcre2_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(pcre2_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pcre2_FRAMEWORKS_RELWITHDEBINFO}" "${pcre2_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(pcre2_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pcre2_DEPS_TARGET)
    add_library(pcre2_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pcre2_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${pcre2_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${pcre2_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:ZLIB::ZLIB;BZip2::BZip2;PCRE2::8BIT>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pcre2_DEPS_TARGET to all of them
conan_package_library_targets("${pcre2_LIBS_RELWITHDEBINFO}"    # libraries
                              "${pcre2_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${pcre2_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pcre2_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pcre2_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pcre2_DEPS_TARGET
                              pcre2_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "pcre2"    # package_name
                              "${pcre2_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pcre2_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES RelWithDebInfo ########################################

    ########## COMPONENT PCRE2::POSIX #############

        set(pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pcre2_PCRE2_POSIX_FRAMEWORKS_RELWITHDEBINFO}" "${pcre2_PCRE2_POSIX_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(pcre2_PCRE2_POSIX_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_POSIX_DEPS_TARGET)
            add_library(pcre2_PCRE2_POSIX_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_POSIX_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_POSIX_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_POSIX_LIBS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_POSIX_LIB_DIRS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_POSIX_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pcre2_PCRE2_POSIX_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_POSIX_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pcre2_PCRE2_POSIX_DEPS_TARGET
                              pcre2_PCRE2_POSIX_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "pcre2_PCRE2_POSIX"
                              "${pcre2_PCRE2_POSIX_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::POSIX
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_LIBRARIES_TARGETS}>
                     )

        if("${pcre2_PCRE2_POSIX_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::POSIX
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_POSIX_DEPS_TARGET)
        endif()

        set_property(TARGET PCRE2::POSIX APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::POSIX APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::POSIX APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::POSIX APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::POSIX APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_POSIX_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT PCRE2::32BIT #############

        set(pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pcre2_PCRE2_32BIT_FRAMEWORKS_RELWITHDEBINFO}" "${pcre2_PCRE2_32BIT_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(pcre2_PCRE2_32BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_32BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_32BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_32BIT_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_32BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_32BIT_LIBS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_32BIT_LIB_DIRS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_32BIT_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pcre2_PCRE2_32BIT_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_32BIT_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pcre2_PCRE2_32BIT_DEPS_TARGET
                              pcre2_PCRE2_32BIT_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "pcre2_PCRE2_32BIT"
                              "${pcre2_PCRE2_32BIT_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::32BIT
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_LIBRARIES_TARGETS}>
                     )

        if("${pcre2_PCRE2_32BIT_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::32BIT
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_32BIT_DEPS_TARGET)
        endif()

        set_property(TARGET PCRE2::32BIT APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::32BIT APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::32BIT APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::32BIT APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::32BIT APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_32BIT_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT PCRE2::16BIT #############

        set(pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pcre2_PCRE2_16BIT_FRAMEWORKS_RELWITHDEBINFO}" "${pcre2_PCRE2_16BIT_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(pcre2_PCRE2_16BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_16BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_16BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_16BIT_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_16BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_16BIT_LIBS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_16BIT_LIB_DIRS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_16BIT_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pcre2_PCRE2_16BIT_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_16BIT_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pcre2_PCRE2_16BIT_DEPS_TARGET
                              pcre2_PCRE2_16BIT_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "pcre2_PCRE2_16BIT"
                              "${pcre2_PCRE2_16BIT_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::16BIT
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_LIBRARIES_TARGETS}>
                     )

        if("${pcre2_PCRE2_16BIT_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::16BIT
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_16BIT_DEPS_TARGET)
        endif()

        set_property(TARGET PCRE2::16BIT APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::16BIT APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::16BIT APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::16BIT APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::16BIT APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_16BIT_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT PCRE2::8BIT #############

        set(pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO "${pcre2_PCRE2_8BIT_FRAMEWORKS_RELWITHDEBINFO}" "${pcre2_PCRE2_8BIT_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(pcre2_PCRE2_8BIT_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre2_PCRE2_8BIT_DEPS_TARGET)
            add_library(pcre2_PCRE2_8BIT_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre2_PCRE2_8BIT_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre2_PCRE2_8BIT_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre2_PCRE2_8BIT_LIBS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_8BIT_LIB_DIRS_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_8BIT_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${pcre2_PCRE2_8BIT_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${pcre2_PCRE2_8BIT_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              pcre2_PCRE2_8BIT_DEPS_TARGET
                              pcre2_PCRE2_8BIT_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "pcre2_PCRE2_8BIT"
                              "${pcre2_PCRE2_8BIT_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET PCRE2::8BIT
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_LIBRARIES_TARGETS}>
                     )

        if("${pcre2_PCRE2_8BIT_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET PCRE2::8BIT
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre2_PCRE2_8BIT_DEPS_TARGET)
        endif()

        set_property(TARGET PCRE2::8BIT APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::8BIT APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::8BIT APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::8BIT APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET PCRE2::8BIT APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${pcre2_PCRE2_8BIT_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET pcre2::pcre2 APPEND PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::POSIX)
    set_property(TARGET pcre2::pcre2 APPEND PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::32BIT)
    set_property(TARGET pcre2::pcre2 APPEND PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::16BIT)
    set_property(TARGET pcre2::pcre2 APPEND PROPERTY INTERFACE_LINK_LIBRARIES PCRE2::8BIT)

########## For the modules (FindXXX)
set(pcre2_LIBRARIES_RELWITHDEBINFO pcre2::pcre2)
