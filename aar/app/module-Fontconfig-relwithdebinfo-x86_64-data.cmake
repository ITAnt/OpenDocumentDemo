########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(fontconfig_COMPONENT_NAMES "")
if(DEFINED fontconfig_FIND_DEPENDENCY_NAMES)
  list(APPEND fontconfig_FIND_DEPENDENCY_NAMES EXPAT Freetype)
  list(REMOVE_DUPLICATES fontconfig_FIND_DEPENDENCY_NAMES)
else()
  set(fontconfig_FIND_DEPENDENCY_NAMES EXPAT Freetype)
endif()
set(EXPAT_FIND_MODE "MODULE")
set(Freetype_FIND_MODE "MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(fontconfig_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/fontc6c455df2369b3/p")
set(fontconfig_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(fontconfig_INCLUDE_DIRS_RELWITHDEBINFO )
set(fontconfig_RES_DIRS_RELWITHDEBINFO "${fontconfig_PACKAGE_FOLDER_RELWITHDEBINFO}/res/share")
set(fontconfig_DEFINITIONS_RELWITHDEBINFO )
set(fontconfig_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(fontconfig_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(fontconfig_OBJECTS_RELWITHDEBINFO )
set(fontconfig_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(fontconfig_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(fontconfig_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(fontconfig_LIB_DIRS_RELWITHDEBINFO "${fontconfig_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(fontconfig_BIN_DIRS_RELWITHDEBINFO )
set(fontconfig_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(fontconfig_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(fontconfig_LIBS_RELWITHDEBINFO fontconfig)
set(fontconfig_SYSTEM_LIBS_RELWITHDEBINFO )
set(fontconfig_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(fontconfig_FRAMEWORKS_RELWITHDEBINFO )
set(fontconfig_BUILD_DIRS_RELWITHDEBINFO )
set(fontconfig_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(fontconfig_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${fontconfig_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${fontconfig_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(fontconfig_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${fontconfig_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${fontconfig_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${fontconfig_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(fontconfig_COMPONENTS_RELWITHDEBINFO )