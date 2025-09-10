########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(pdf2htmlex_COMPONENT_NAMES "")
if(DEFINED pdf2htmlex_FIND_DEPENDENCY_NAMES)
  list(APPEND pdf2htmlex_FIND_DEPENDENCY_NAMES poppler cairo fontforge freetype glib)
  list(REMOVE_DUPLICATES pdf2htmlex_FIND_DEPENDENCY_NAMES)
else()
  set(pdf2htmlex_FIND_DEPENDENCY_NAMES poppler cairo fontforge freetype glib)
endif()
set(poppler_FIND_MODE "NO_MODULE")
set(cairo_FIND_MODE "NO_MODULE")
set(fontforge_FIND_MODE "NO_MODULE")
set(freetype_FIND_MODE "NO_MODULE")
set(glib_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(pdf2htmlex_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/pdf2h86c1174c68f88/p")
set(pdf2htmlex_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(pdf2htmlex_INCLUDE_DIRS_RELWITHDEBINFO )
set(pdf2htmlex_RES_DIRS_RELWITHDEBINFO "${pdf2htmlex_PACKAGE_FOLDER_RELWITHDEBINFO}/share/pdf2htmlEX")
set(pdf2htmlex_DEFINITIONS_RELWITHDEBINFO )
set(pdf2htmlex_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(pdf2htmlex_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(pdf2htmlex_OBJECTS_RELWITHDEBINFO )
set(pdf2htmlex_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(pdf2htmlex_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(pdf2htmlex_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(pdf2htmlex_LIB_DIRS_RELWITHDEBINFO "${pdf2htmlex_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(pdf2htmlex_BIN_DIRS_RELWITHDEBINFO )
set(pdf2htmlex_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(pdf2htmlex_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(pdf2htmlex_LIBS_RELWITHDEBINFO pdf2htmlEX)
set(pdf2htmlex_SYSTEM_LIBS_RELWITHDEBINFO )
set(pdf2htmlex_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(pdf2htmlex_FRAMEWORKS_RELWITHDEBINFO )
set(pdf2htmlex_BUILD_DIRS_RELWITHDEBINFO )
set(pdf2htmlex_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(pdf2htmlex_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${pdf2htmlex_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${pdf2htmlex_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(pdf2htmlex_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pdf2htmlex_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pdf2htmlex_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pdf2htmlex_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(pdf2htmlex_COMPONENTS_RELWITHDEBINFO )