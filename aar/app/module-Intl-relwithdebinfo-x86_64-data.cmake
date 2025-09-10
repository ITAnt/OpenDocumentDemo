########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(libgettext_COMPONENT_NAMES "")
if(DEFINED libgettext_FIND_DEPENDENCY_NAMES)
  list(APPEND libgettext_FIND_DEPENDENCY_NAMES Iconv)
  list(REMOVE_DUPLICATES libgettext_FIND_DEPENDENCY_NAMES)
else()
  set(libgettext_FIND_DEPENDENCY_NAMES Iconv)
endif()
set(Iconv_FIND_MODE "MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(libgettext_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/libge6884e292e2fe4/p")
set(libgettext_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(libgettext_INCLUDE_DIRS_RELWITHDEBINFO )
set(libgettext_RES_DIRS_RELWITHDEBINFO )
set(libgettext_DEFINITIONS_RELWITHDEBINFO )
set(libgettext_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(libgettext_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(libgettext_OBJECTS_RELWITHDEBINFO )
set(libgettext_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(libgettext_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(libgettext_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(libgettext_LIB_DIRS_RELWITHDEBINFO "${libgettext_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(libgettext_BIN_DIRS_RELWITHDEBINFO )
set(libgettext_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(libgettext_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(libgettext_LIBS_RELWITHDEBINFO gnuintl)
set(libgettext_SYSTEM_LIBS_RELWITHDEBINFO )
set(libgettext_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(libgettext_FRAMEWORKS_RELWITHDEBINFO )
set(libgettext_BUILD_DIRS_RELWITHDEBINFO )
set(libgettext_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(libgettext_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${libgettext_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${libgettext_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(libgettext_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libgettext_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libgettext_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libgettext_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(libgettext_COMPONENTS_RELWITHDEBINFO )