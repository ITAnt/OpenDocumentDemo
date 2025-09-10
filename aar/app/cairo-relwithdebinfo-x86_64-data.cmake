########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND cairo_COMPONENT_NAMES cairo::cairo_ cairo::cairo-png cairo::cairo-svg cairo::cairo-fc cairo::cairo-ft cairo::cairo-script cairo::cairo-ps cairo::cairo-pdf cairo::cairo-script-interpreter cairo::cairo-xml cairo::cairo-util_ cairo::cairo-gobject)
list(REMOVE_DUPLICATES cairo_COMPONENT_NAMES)
if(DEFINED cairo_FIND_DEPENDENCY_NAMES)
  list(APPEND cairo_FIND_DEPENDENCY_NAMES pixman lzo Fontconfig expat freetype glib PNG ZLIB)
  list(REMOVE_DUPLICATES cairo_FIND_DEPENDENCY_NAMES)
else()
  set(cairo_FIND_DEPENDENCY_NAMES pixman lzo Fontconfig expat freetype glib PNG ZLIB)
endif()
set(pixman_FIND_MODE "NO_MODULE")
set(lzo_FIND_MODE "NO_MODULE")
set(Fontconfig_FIND_MODE "NO_MODULE")
set(expat_FIND_MODE "NO_MODULE")
set(freetype_FIND_MODE "NO_MODULE")
set(glib_FIND_MODE "NO_MODULE")
set(PNG_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(cairo_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/cairo69b876718fff9/p")
set(cairo_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(cairo_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_RES_DIRS_RELWITHDEBINFO )
set(cairo_DEFINITIONS_RELWITHDEBINFO )
set(cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_OBJECTS_RELWITHDEBINFO )
set(cairo_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(cairo_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(cairo_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_BIN_DIRS_RELWITHDEBINFO )
set(cairo_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_LIBS_RELWITHDEBINFO cairo-gobject cairo-script-interpreter cairo)
set(cairo_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_BUILD_DIRS_RELWITHDEBINFO )
set(cairo_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(cairo_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(cairo_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(cairo_COMPONENTS_RELWITHDEBINFO cairo::cairo_ cairo::cairo-png cairo::cairo-svg cairo::cairo-fc cairo::cairo-ft cairo::cairo-script cairo::cairo-ps cairo::cairo-pdf cairo::cairo-script-interpreter cairo::cairo-xml cairo::cairo-util_ cairo::cairo-gobject)
########### COMPONENT cairo::cairo-gobject VARIABLES ############################################

set(cairo_cairo_cairo-gobject_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-gobject_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-gobject_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-gobject_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-gobject_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-gobject_LIBS_RELWITHDEBINFO cairo-gobject)
set(cairo_cairo_cairo-gobject_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ glib::gobject-2.0 glib::glib-2.0)
set(cairo_cairo_cairo-gobject_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-gobject_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-gobject_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-gobject_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-gobject_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-gobject_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-gobject_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-gobject_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-gobject_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-util_ VARIABLES ############################################

set(cairo_cairo_cairo-util__INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-util__BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-util__IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-util__RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-util__COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-util__LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ expat::expat)
set(cairo_cairo_cairo-util__SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-util__NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-util__LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-util__SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-util__SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-util__EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-util__COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-util__COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-util__COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-xml VARIABLES ############################################

set(cairo_cairo_cairo-xml_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-xml_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-xml_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-xml_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-xml_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-xml_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ ZLIB::ZLIB)
set(cairo_cairo_cairo-xml_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-xml_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-xml_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-xml_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-xml_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-xml_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-xml_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-xml_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-xml_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-script-interpreter VARIABLES ############################################

set(cairo_cairo_cairo-script-interpreter_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-script-interpreter_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-script-interpreter_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-script-interpreter_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-script-interpreter_LIBS_RELWITHDEBINFO cairo-script-interpreter)
set(cairo_cairo_cairo-script-interpreter_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_)
set(cairo_cairo_cairo-script-interpreter_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script-interpreter_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-script-interpreter_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-script-interpreter_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-script-interpreter_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-script-interpreter_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-script-interpreter_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-pdf VARIABLES ############################################

set(cairo_cairo_cairo-pdf_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-pdf_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-pdf_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-pdf_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-pdf_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-pdf_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ ZLIB::ZLIB)
set(cairo_cairo_cairo-pdf_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-pdf_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-pdf_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-pdf_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-pdf_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-pdf_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-pdf_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-pdf_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-pdf_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-ps VARIABLES ############################################

set(cairo_cairo_cairo-ps_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-ps_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-ps_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-ps_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-ps_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-ps_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ ZLIB::ZLIB)
set(cairo_cairo_cairo-ps_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ps_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-ps_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-ps_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-ps_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-ps_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-ps_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-ps_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-ps_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-script VARIABLES ############################################

set(cairo_cairo_cairo-script_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-script_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-script_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-script_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-script_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-script_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ ZLIB::ZLIB)
set(cairo_cairo_cairo-script_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-script_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-script_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-script_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-script_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-script_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-script_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-script_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-script_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-ft VARIABLES ############################################

set(cairo_cairo_cairo-ft_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-ft_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-ft_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-ft_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-ft_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-ft_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ Freetype::Freetype)
set(cairo_cairo_cairo-ft_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-ft_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-ft_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-ft_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-ft_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-ft_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-ft_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-ft_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-ft_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-fc VARIABLES ############################################

set(cairo_cairo_cairo-fc_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-fc_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-fc_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-fc_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-fc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-fc_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ Fontconfig::Fontconfig)
set(cairo_cairo_cairo-fc_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-fc_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-fc_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-fc_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-fc_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-fc_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-fc_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-fc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-fc_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-svg VARIABLES ############################################

set(cairo_cairo_cairo-svg_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-svg_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-svg_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-svg_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-svg_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-svg_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ PNG::PNG)
set(cairo_cairo_cairo-svg_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-svg_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-svg_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-svg_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-svg_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-svg_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-svg_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-svg_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-svg_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo-png VARIABLES ############################################

set(cairo_cairo_cairo-png_INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo-png_BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo-png_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo-png_RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo-png_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo-png_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_DEPENDENCIES_RELWITHDEBINFO cairo::cairo_ PNG::PNG)
set(cairo_cairo_cairo-png_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo-png_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo-png_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo-png_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo-png_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo-png_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo-png_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo-png_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo-png_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT cairo::cairo_ VARIABLES ############################################

set(cairo_cairo_cairo__INCLUDE_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo__LIB_DIRS_RELWITHDEBINFO "${cairo_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(cairo_cairo_cairo__BIN_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo__LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(cairo_cairo_cairo__IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(cairo_cairo_cairo__RES_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo__DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo__OBJECTS_RELWITHDEBINFO )
set(cairo_cairo_cairo__COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(cairo_cairo_cairo__COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(cairo_cairo_cairo__COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(cairo_cairo_cairo__LIBS_RELWITHDEBINFO cairo)
set(cairo_cairo_cairo__SYSTEM_LIBS_RELWITHDEBINFO )
set(cairo_cairo_cairo__FRAMEWORK_DIRS_RELWITHDEBINFO )
set(cairo_cairo_cairo__FRAMEWORKS_RELWITHDEBINFO )
set(cairo_cairo_cairo__DEPENDENCIES_RELWITHDEBINFO lzo::lzo ZLIB::ZLIB PNG::PNG Fontconfig::Fontconfig Freetype::Freetype expat::expat ZLIB::ZLIB pixman::pixman)
set(cairo_cairo_cairo__SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo__EXE_LINK_FLAGS_RELWITHDEBINFO )
set(cairo_cairo_cairo__NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(cairo_cairo_cairo__LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cairo_cairo_cairo__SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cairo_cairo_cairo__SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cairo_cairo_cairo__EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(cairo_cairo_cairo__COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${cairo_cairo_cairo__COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${cairo_cairo_cairo__COMPILE_OPTIONS_C_RELWITHDEBINFO}>")