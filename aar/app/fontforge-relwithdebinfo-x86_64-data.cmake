########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(fontforge_COMPONENT_NAMES "")
if(DEFINED fontforge_FIND_DEPENDENCY_NAMES)
  list(APPEND fontforge_FIND_DEPENDENCY_NAMES freetype GIF JPEG glib Intl PNG libxml2)
  list(REMOVE_DUPLICATES fontforge_FIND_DEPENDENCY_NAMES)
else()
  set(fontforge_FIND_DEPENDENCY_NAMES freetype GIF JPEG glib Intl PNG libxml2)
endif()
set(freetype_FIND_MODE "NO_MODULE")
set(GIF_FIND_MODE "NO_MODULE")
set(JPEG_FIND_MODE "NO_MODULE")
set(glib_FIND_MODE "NO_MODULE")
set(Intl_FIND_MODE "NO_MODULE")
set(PNG_FIND_MODE "NO_MODULE")
set(libxml2_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(fontforge_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/fontf001ebf16477bd/p")
set(fontforge_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(fontforge_INCLUDE_DIRS_RELWITHDEBINFO )
set(fontforge_RES_DIRS_RELWITHDEBINFO )
set(fontforge_DEFINITIONS_RELWITHDEBINFO )
set(fontforge_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(fontforge_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(fontforge_OBJECTS_RELWITHDEBINFO )
set(fontforge_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(fontforge_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(fontforge_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(fontforge_LIB_DIRS_RELWITHDEBINFO "${fontforge_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(fontforge_BIN_DIRS_RELWITHDEBINFO )
set(fontforge_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(fontforge_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(fontforge_LIBS_RELWITHDEBINFO fontforge)
set(fontforge_SYSTEM_LIBS_RELWITHDEBINFO )
set(fontforge_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(fontforge_FRAMEWORKS_RELWITHDEBINFO )
set(fontforge_BUILD_DIRS_RELWITHDEBINFO )
set(fontforge_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(fontforge_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${fontforge_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${fontforge_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(fontforge_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${fontforge_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${fontforge_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${fontforge_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(fontforge_COMPONENTS_RELWITHDEBINFO )