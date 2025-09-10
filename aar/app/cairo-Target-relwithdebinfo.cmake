# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
conan_find_apple_frameworks(cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_FRAMEWORK_DIRS_RELWITHDEBINFO}")

set(cairo_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET cairo_DEPS_TARGET)
    add_library(cairo_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET cairo_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:RelWithDebInfo>:${cairo_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:${cairo_SYSTEM_LIBS_RELWITHDEBINFO}>
             $<$<CONFIG:RelWithDebInfo>:lzo::lzo;ZLIB::ZLIB;PNG::PNG;Fontconfig::Fontconfig;Freetype::Freetype;expat::expat;pixman::pixman;cairo::cairo_;glib::gobject-2.0;glib::glib-2.0>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### cairo_DEPS_TARGET to all of them
conan_package_library_targets("${cairo_LIBS_RELWITHDEBINFO}"    # libraries
                              "${cairo_LIB_DIRS_RELWITHDEBINFO}" # package_libdir
                              "${cairo_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_DEPS_TARGET
                              cairo_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELWITHDEBINFO"
                              "cairo"    # package_name
                              "${cairo_NO_SONAME_MODE_RELWITHDEBINFO}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${cairo_BUILD_DIRS_RELWITHDEBINFO} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES RelWithDebInfo ########################################

    ########## COMPONENT cairo::cairo-gobject #############

        set(cairo_cairo_cairo-gobject_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-gobject_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-gobject_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-gobject_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-gobject_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-gobject_DEPS_TARGET)
            add_library(cairo_cairo_cairo-gobject_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-gobject_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-gobject_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-gobject_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-gobject_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-gobject_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-gobject_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-gobject_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-gobject_DEPS_TARGET
                              cairo_cairo_cairo-gobject_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-gobject"
                              "${cairo_cairo_cairo-gobject_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-gobject
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-gobject_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-gobject
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-gobject_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-gobject APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-gobject APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-gobject APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-gobject APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-gobject APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-gobject_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-util_ #############

        set(cairo_cairo_cairo-util__FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-util__FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-util__FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-util__FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-util__LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-util__DEPS_TARGET)
            add_library(cairo_cairo_cairo-util__DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-util__DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-util__DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-util__LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-util__LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-util__BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-util__LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-util__IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-util__DEPS_TARGET
                              cairo_cairo_cairo-util__LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-util_"
                              "${cairo_cairo_cairo-util__NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-util_
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-util__LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-util_
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-util__DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-util_ APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-util_ APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-util_ APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-util_ APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-util_ APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-util__COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-xml #############

        set(cairo_cairo_cairo-xml_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-xml_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-xml_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-xml_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-xml_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-xml_DEPS_TARGET)
            add_library(cairo_cairo_cairo-xml_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-xml_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-xml_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-xml_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-xml_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-xml_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-xml_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-xml_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-xml_DEPS_TARGET
                              cairo_cairo_cairo-xml_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-xml"
                              "${cairo_cairo_cairo-xml_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-xml
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-xml_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-xml
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-xml_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-xml APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-xml APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-xml APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-xml APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-xml APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-xml_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-script-interpreter #############

        set(cairo_cairo_cairo-script-interpreter_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-script-interpreter_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-script-interpreter_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-script-interpreter_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-script-interpreter_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-script-interpreter_DEPS_TARGET)
            add_library(cairo_cairo_cairo-script-interpreter_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-script-interpreter_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-script-interpreter_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-script-interpreter_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script-interpreter_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script-interpreter_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-script-interpreter_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script-interpreter_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-script-interpreter_DEPS_TARGET
                              cairo_cairo_cairo-script-interpreter_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-script-interpreter"
                              "${cairo_cairo_cairo-script-interpreter_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-script-interpreter
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-script-interpreter_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-script-interpreter
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-script-interpreter_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-script-interpreter APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script-interpreter APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script-interpreter APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script-interpreter APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script-interpreter APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-pdf #############

        set(cairo_cairo_cairo-pdf_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-pdf_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-pdf_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-pdf_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-pdf_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-pdf_DEPS_TARGET)
            add_library(cairo_cairo_cairo-pdf_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-pdf_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-pdf_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-pdf_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-pdf_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-pdf_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-pdf_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-pdf_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-pdf_DEPS_TARGET
                              cairo_cairo_cairo-pdf_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-pdf"
                              "${cairo_cairo_cairo-pdf_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-pdf
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-pdf_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-pdf
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-pdf_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-pdf APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-pdf APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-pdf APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-pdf APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-pdf APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-pdf_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-ps #############

        set(cairo_cairo_cairo-ps_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-ps_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-ps_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-ps_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-ps_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-ps_DEPS_TARGET)
            add_library(cairo_cairo_cairo-ps_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-ps_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-ps_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-ps_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ps_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ps_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-ps_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ps_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-ps_DEPS_TARGET
                              cairo_cairo_cairo-ps_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-ps"
                              "${cairo_cairo_cairo-ps_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-ps
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-ps_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-ps
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-ps_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-ps APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ps APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ps APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ps APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ps APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ps_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-script #############

        set(cairo_cairo_cairo-script_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-script_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-script_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-script_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-script_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-script_DEPS_TARGET)
            add_library(cairo_cairo_cairo-script_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-script_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-script_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-script_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-script_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-script_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-script_DEPS_TARGET
                              cairo_cairo_cairo-script_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-script"
                              "${cairo_cairo_cairo-script_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-script
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-script_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-script
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-script_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-script APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-script APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-script_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-ft #############

        set(cairo_cairo_cairo-ft_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-ft_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-ft_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-ft_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-ft_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-ft_DEPS_TARGET)
            add_library(cairo_cairo_cairo-ft_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-ft_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-ft_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-ft_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ft_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ft_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-ft_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-ft_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-ft_DEPS_TARGET
                              cairo_cairo_cairo-ft_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-ft"
                              "${cairo_cairo_cairo-ft_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-ft
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-ft_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-ft
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-ft_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-ft APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ft APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ft APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ft APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-ft APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-ft_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-fc #############

        set(cairo_cairo_cairo-fc_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-fc_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-fc_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-fc_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-fc_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-fc_DEPS_TARGET)
            add_library(cairo_cairo_cairo-fc_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-fc_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-fc_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-fc_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-fc_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-fc_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-fc_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-fc_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-fc_DEPS_TARGET
                              cairo_cairo_cairo-fc_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-fc"
                              "${cairo_cairo_cairo-fc_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-fc
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-fc_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-fc
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-fc_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-fc APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-fc APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-fc APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-fc APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-fc APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-fc_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-svg #############

        set(cairo_cairo_cairo-svg_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-svg_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-svg_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-svg_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-svg_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-svg_DEPS_TARGET)
            add_library(cairo_cairo_cairo-svg_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-svg_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-svg_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-svg_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-svg_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-svg_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-svg_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-svg_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-svg_DEPS_TARGET
                              cairo_cairo_cairo-svg_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-svg"
                              "${cairo_cairo_cairo-svg_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-svg
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-svg_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-svg
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-svg_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-svg APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-svg APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-svg APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-svg APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-svg APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-svg_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo-png #############

        set(cairo_cairo_cairo-png_FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo-png_FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo-png_FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo-png_FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo-png_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo-png_DEPS_TARGET)
            add_library(cairo_cairo_cairo-png_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo-png_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo-png_DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo-png_LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-png_LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-png_BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo-png_LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo-png_IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo-png_DEPS_TARGET
                              cairo_cairo_cairo-png_LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo-png"
                              "${cairo_cairo_cairo-png_NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo-png
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo-png_LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo-png
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo-png_DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo-png APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-png APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-png APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-png APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo-png APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo-png_COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## COMPONENT cairo::cairo_ #############

        set(cairo_cairo_cairo__FRAMEWORKS_FOUND_RELWITHDEBINFO "")
        conan_find_apple_frameworks(cairo_cairo_cairo__FRAMEWORKS_FOUND_RELWITHDEBINFO "${cairo_cairo_cairo__FRAMEWORKS_RELWITHDEBINFO}" "${cairo_cairo_cairo__FRAMEWORK_DIRS_RELWITHDEBINFO}")

        set(cairo_cairo_cairo__LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET cairo_cairo_cairo__DEPS_TARGET)
            add_library(cairo_cairo_cairo__DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET cairo_cairo_cairo__DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__FRAMEWORKS_FOUND_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__SYSTEM_LIBS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__DEPENDENCIES_RELWITHDEBINFO}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'cairo_cairo_cairo__DEPS_TARGET' to all of them
        conan_package_library_targets("${cairo_cairo_cairo__LIBS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo__LIB_DIRS_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo__BIN_DIRS_RELWITHDEBINFO}" # package_bindir
                              "${cairo_cairo_cairo__LIBRARY_TYPE_RELWITHDEBINFO}"
                              "${cairo_cairo_cairo__IS_HOST_WINDOWS_RELWITHDEBINFO}"
                              cairo_cairo_cairo__DEPS_TARGET
                              cairo_cairo_cairo__LIBRARIES_TARGETS
                              "_RELWITHDEBINFO"
                              "cairo_cairo_cairo_"
                              "${cairo_cairo_cairo__NO_SONAME_MODE_RELWITHDEBINFO}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET cairo::cairo_
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__OBJECTS_RELWITHDEBINFO}>
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__LIBRARIES_TARGETS}>
                     )

        if("${cairo_cairo_cairo__LIBS_RELWITHDEBINFO}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET cairo::cairo_
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         cairo_cairo_cairo__DEPS_TARGET)
        endif()

        set_property(TARGET cairo::cairo_ APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__LINKER_FLAGS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo_ APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__INCLUDE_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo_ APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__LIB_DIRS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo_ APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__COMPILE_DEFINITIONS_RELWITHDEBINFO}>)
        set_property(TARGET cairo::cairo_ APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:RelWithDebInfo>:${cairo_cairo_cairo__COMPILE_OPTIONS_RELWITHDEBINFO}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-gobject)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-util_)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-xml)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-script-interpreter)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-pdf)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-ps)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-script)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-ft)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-fc)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-svg)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo-png)
    set_property(TARGET cairo::cairo APPEND PROPERTY INTERFACE_LINK_LIBRARIES cairo::cairo_)

########## For the modules (FindXXX)
set(cairo_LIBRARIES_RELWITHDEBINFO cairo::cairo)
