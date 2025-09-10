# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(poppler_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(poppler_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(poppler_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET poppler_DEPS_TARGET)
    add_library(poppler_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET poppler_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${poppler_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${poppler_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:poppler-data::poppler-data;Freetype::Freetype;Fontconfig::Fontconfig;openjp2;lcms::lcms;JPEG::JPEG;PNG::PNG;ZLIB::ZLIB;poppler::libpoppler;Iconv::Iconv;cairo::cairo;poppler::libpoppler-cairo;glib::glib>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### poppler_DEPS_TARGET to all of them
conan_package_library_targets("${poppler_LIBS_RELWITHDEBINFO}"    # libraries
                              "${poppler_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${poppler_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_DEPS_TARGET
                              poppler_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "poppler"    # package_name
                              "${poppler_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${poppler_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES RelWithDebInfo ########################################

    ########## COMPONENT poppler::libpoppler-glib #############

        set(poppler_poppler_libpoppler-glib_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(poppler_poppler_libpoppler-glib_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_poppler_libpoppler-glib_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_poppler_libpoppler-glib_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(poppler_poppler_libpoppler-glib_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poppler_poppler_libpoppler-glib_DEPS_TARGET)
            add_library(poppler_poppler_libpoppler-glib_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poppler_poppler_libpoppler-glib_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poppler_poppler_libpoppler-glib_DEPS_TARGET' to all of them
        conan_package_library_targets("${poppler_poppler_libpoppler-glib_LIBS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-glib_LIB_DIRS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-glib_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_poppler_libpoppler-glib_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-glib_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_poppler_libpoppler-glib_DEPS_TARGET
                              poppler_poppler_libpoppler-glib_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "poppler_poppler_libpoppler-glib"
                              "${poppler_poppler_libpoppler-glib_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET poppler::libpoppler-glib
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_LIBRARIES_TARGETS}>
                     )

        if("${poppler_poppler_libpoppler-glib_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET poppler::libpoppler-glib
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         poppler_poppler_libpoppler-glib_DEPS_TARGET)
        endif()

        set_property(TARGET poppler::libpoppler-glib APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-glib APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-glib APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-glib APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-glib APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT poppler::libpoppler-cairo #############

        set(poppler_poppler_libpoppler-cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(poppler_poppler_libpoppler-cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_poppler_libpoppler-cairo_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_poppler_libpoppler-cairo_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(poppler_poppler_libpoppler-cairo_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poppler_poppler_libpoppler-cairo_DEPS_TARGET)
            add_library(poppler_poppler_libpoppler-cairo_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poppler_poppler_libpoppler-cairo_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poppler_poppler_libpoppler-cairo_DEPS_TARGET' to all of them
        conan_package_library_targets("${poppler_poppler_libpoppler-cairo_LIBS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cairo_LIB_DIRS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cairo_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_poppler_libpoppler-cairo_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cairo_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_poppler_libpoppler-cairo_DEPS_TARGET
                              poppler_poppler_libpoppler-cairo_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "poppler_poppler_libpoppler-cairo"
                              "${poppler_poppler_libpoppler-cairo_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET poppler::libpoppler-cairo
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_LIBRARIES_TARGETS}>
                     )

        if("${poppler_poppler_libpoppler-cairo_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET poppler::libpoppler-cairo
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         poppler_poppler_libpoppler-cairo_DEPS_TARGET)
        endif()

        set_property(TARGET poppler::libpoppler-cairo APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cairo APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cairo APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cairo APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cairo APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT poppler::libpoppler-splash #############

        set(poppler_poppler_libpoppler-splash_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(poppler_poppler_libpoppler-splash_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_poppler_libpoppler-splash_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_poppler_libpoppler-splash_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(poppler_poppler_libpoppler-splash_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poppler_poppler_libpoppler-splash_DEPS_TARGET)
            add_library(poppler_poppler_libpoppler-splash_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poppler_poppler_libpoppler-splash_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poppler_poppler_libpoppler-splash_DEPS_TARGET' to all of them
        conan_package_library_targets("${poppler_poppler_libpoppler-splash_LIBS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-splash_LIB_DIRS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-splash_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_poppler_libpoppler-splash_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-splash_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_poppler_libpoppler-splash_DEPS_TARGET
                              poppler_poppler_libpoppler-splash_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "poppler_poppler_libpoppler-splash"
                              "${poppler_poppler_libpoppler-splash_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET poppler::libpoppler-splash
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_LIBRARIES_TARGETS}>
                     )

        if("${poppler_poppler_libpoppler-splash_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET poppler::libpoppler-splash
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         poppler_poppler_libpoppler-splash_DEPS_TARGET)
        endif()

        set_property(TARGET poppler::libpoppler-splash APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-splash APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-splash APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-splash APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-splash APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT poppler::libpoppler-cpp #############

        set(poppler_poppler_libpoppler-cpp_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(poppler_poppler_libpoppler-cpp_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_poppler_libpoppler-cpp_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_poppler_libpoppler-cpp_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(poppler_poppler_libpoppler-cpp_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poppler_poppler_libpoppler-cpp_DEPS_TARGET)
            add_library(poppler_poppler_libpoppler-cpp_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poppler_poppler_libpoppler-cpp_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poppler_poppler_libpoppler-cpp_DEPS_TARGET' to all of them
        conan_package_library_targets("${poppler_poppler_libpoppler-cpp_LIBS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cpp_LIB_DIRS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cpp_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_poppler_libpoppler-cpp_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler-cpp_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_poppler_libpoppler-cpp_DEPS_TARGET
                              poppler_poppler_libpoppler-cpp_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "poppler_poppler_libpoppler-cpp"
                              "${poppler_poppler_libpoppler-cpp_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET poppler::libpoppler-cpp
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_LIBRARIES_TARGETS}>
                     )

        if("${poppler_poppler_libpoppler-cpp_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET poppler::libpoppler-cpp
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         poppler_poppler_libpoppler-cpp_DEPS_TARGET)
        endif()

        set_property(TARGET poppler::libpoppler-cpp APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cpp APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cpp APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cpp APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler-cpp APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT poppler::libpoppler #############

        set(poppler_poppler_libpoppler_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(poppler_poppler_libpoppler_FRAMEWORKS_FOUND_RELWITHDEBINFO "${poppler_poppler_libpoppler_FRAMEWORKS_RELWITHDEBINFO}" "${poppler_poppler_libpoppler_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(poppler_poppler_libpoppler_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET poppler_poppler_libpoppler_DEPS_TARGET)
            add_library(poppler_poppler_libpoppler_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET poppler_poppler_libpoppler_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'poppler_poppler_libpoppler_DEPS_TARGET' to all of them
        conan_package_library_targets("${poppler_poppler_libpoppler_LIBS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler_LIB_DIRS_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${poppler_poppler_libpoppler_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${poppler_poppler_libpoppler_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              poppler_poppler_libpoppler_DEPS_TARGET
                              poppler_poppler_libpoppler_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "poppler_poppler_libpoppler"
                              "${poppler_poppler_libpoppler_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET poppler::libpoppler
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_LIBRARIES_TARGETS}>
                     )

        if("${poppler_poppler_libpoppler_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET poppler::libpoppler
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         poppler_poppler_libpoppler_DEPS_TARGET)
        endif()

        set_property(TARGET poppler::libpoppler APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET poppler::libpoppler APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${poppler_poppler_libpoppler_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET poppler::poppler APPEND PROPERTY INTERFACE_LINK_LIBRARIES poppler::libpoppler-glib)
    set_property(TARGET poppler::poppler APPEND PROPERTY INTERFACE_LINK_LIBRARIES poppler::libpoppler-cairo)
    set_property(TARGET poppler::poppler APPEND PROPERTY INTERFACE_LINK_LIBRARIES poppler::libpoppler-splash)
    set_property(TARGET poppler::poppler APPEND PROPERTY INTERFACE_LINK_LIBRARIES poppler::libpoppler-cpp)
    set_property(TARGET poppler::poppler APPEND PROPERTY INTERFACE_LINK_LIBRARIES poppler::libpoppler)

########## For the modules (FindXXX)
set(poppler_LIBRARIES_RELWITHDEBINFO poppler::poppler)
