########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(poppler-data_COMPONENT_NAMES "")
if(DEFINED poppler-data_FIND_DEPENDENCY_NAMES)
  list(APPEND poppler-data_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES poppler-data_FIND_DEPENDENCY_NAMES)
else()
  set(poppler-data_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(poppler-data_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/poppl7b8549bdd0928/p")
set(poppler-data_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(poppler-data_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler-data_RES_DIRS_RELWITHDEBINFO "${poppler-data_PACKAGE_FOLDER_RELWITHDEBINFO}/share/poppler")
set(poppler-data_DEFINITIONS_RELWITHDEBINFO )
set(poppler-data_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler-data_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler-data_OBJECTS_RELWITHDEBINFO )
set(poppler-data_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(poppler-data_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(poppler-data_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(poppler-data_LIB_DIRS_RELWITHDEBINFO )
set(poppler-data_BIN_DIRS_RELWITHDEBINFO )
set(poppler-data_LIBRARY_TYPE_RELWITHDEBINFO UNKNOWN)
set(poppler-data_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler-data_LIBS_RELWITHDEBINFO )
set(poppler-data_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler-data_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler-data_FRAMEWORKS_RELWITHDEBINFO )
set(poppler-data_BUILD_DIRS_RELWITHDEBINFO )
set(poppler-data_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(poppler-data_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler-data_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler-data_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(poppler-data_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler-data_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler-data_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler-data_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(poppler-data_COMPONENTS_RELWITHDEBINFO )