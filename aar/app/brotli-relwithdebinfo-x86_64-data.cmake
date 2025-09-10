########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND brotli_COMPONENT_NAMES brotli::brotlicommon brotli::brotlidec brotli::brotlienc)
list(REMOVE_DUPLICATES brotli_COMPONENT_NAMES)
if(DEFINED brotli_FIND_DEPENDENCY_NAMES)
  list(APPEND brotli_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES brotli_FIND_DEPENDENCY_NAMES)
else()
  set(brotli_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(brotli_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/brotlf9e128dd7f347/p")
set(brotli_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(brotli_INCLUDE_DIRS_RELWITHDEBINFO )
set(brotli_RES_DIRS_RELWITHDEBINFO )
set(brotli_DEFINITIONS_RELWITHDEBINFO )
set(brotli_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_OBJECTS_RELWITHDEBINFO )
set(brotli_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(brotli_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(brotli_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(brotli_LIB_DIRS_RELWITHDEBINFO "${brotli_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(brotli_BIN_DIRS_RELWITHDEBINFO )
set(brotli_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(brotli_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(brotli_LIBS_RELWITHDEBINFO brotlienc brotlidec brotlicommon)
set(brotli_SYSTEM_LIBS_RELWITHDEBINFO )
set(brotli_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(brotli_FRAMEWORKS_RELWITHDEBINFO )
set(brotli_BUILD_DIRS_RELWITHDEBINFO )
set(brotli_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(brotli_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${brotli_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${brotli_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(brotli_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${brotli_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${brotli_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${brotli_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(brotli_COMPONENTS_RELWITHDEBINFO brotli::brotlicommon brotli::brotlidec brotli::brotlienc)
########### COMPONENT brotli::brotlienc VARIABLES ############################################

set(brotli_brotli_brotlienc_INCLUDE_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_LIB_DIRS_RELWITHDEBINFO "${brotli_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(brotli_brotli_brotlienc_BIN_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(brotli_brotli_brotlienc_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(brotli_brotli_brotlienc_RES_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_OBJECTS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(brotli_brotli_brotlienc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(brotli_brotli_brotlienc_LIBS_RELWITHDEBINFO brotlienc)
set(brotli_brotli_brotlienc_SYSTEM_LIBS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_FRAMEWORKS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_DEPENDENCIES_RELWITHDEBINFO brotli::brotlicommon)
set(brotli_brotli_brotlienc_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlienc_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(brotli_brotli_brotlienc_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${brotli_brotli_brotlienc_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${brotli_brotli_brotlienc_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${brotli_brotli_brotlienc_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(brotli_brotli_brotlienc_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${brotli_brotli_brotlienc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${brotli_brotli_brotlienc_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT brotli::brotlidec VARIABLES ############################################

set(brotli_brotli_brotlidec_INCLUDE_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_LIB_DIRS_RELWITHDEBINFO "${brotli_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(brotli_brotli_brotlidec_BIN_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(brotli_brotli_brotlidec_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(brotli_brotli_brotlidec_RES_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_OBJECTS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(brotli_brotli_brotlidec_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(brotli_brotli_brotlidec_LIBS_RELWITHDEBINFO brotlidec)
set(brotli_brotli_brotlidec_SYSTEM_LIBS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_FRAMEWORKS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_DEPENDENCIES_RELWITHDEBINFO brotli::brotlicommon)
set(brotli_brotli_brotlidec_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlidec_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(brotli_brotli_brotlidec_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${brotli_brotli_brotlidec_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${brotli_brotli_brotlidec_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${brotli_brotli_brotlidec_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(brotli_brotli_brotlidec_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${brotli_brotli_brotlidec_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${brotli_brotli_brotlidec_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT brotli::brotlicommon VARIABLES ############################################

set(brotli_brotli_brotlicommon_INCLUDE_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_LIB_DIRS_RELWITHDEBINFO "${brotli_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(brotli_brotli_brotlicommon_BIN_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(brotli_brotli_brotlicommon_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(brotli_brotli_brotlicommon_RES_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_OBJECTS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(brotli_brotli_brotlicommon_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(brotli_brotli_brotlicommon_LIBS_RELWITHDEBINFO brotlicommon)
set(brotli_brotli_brotlicommon_SYSTEM_LIBS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_FRAMEWORKS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_DEPENDENCIES_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(brotli_brotli_brotlicommon_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(brotli_brotli_brotlicommon_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${brotli_brotli_brotlicommon_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${brotli_brotli_brotlicommon_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${brotli_brotli_brotlicommon_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(brotli_brotli_brotlicommon_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${brotli_brotli_brotlicommon_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${brotli_brotli_brotlicommon_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")