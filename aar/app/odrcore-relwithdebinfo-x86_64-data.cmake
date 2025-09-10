########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(odrcore_COMPONENT_NAMES "")
if(DEFINED odrcore_FIND_DEPENDENCY_NAMES)
  list(APPEND odrcore_FIND_DEPENDENCY_NAMES pugixml cryptopp miniz uchardet pdf2htmlex wvware argon2)
  list(REMOVE_DUPLICATES odrcore_FIND_DEPENDENCY_NAMES)
else()
  set(odrcore_FIND_DEPENDENCY_NAMES pugixml cryptopp miniz uchardet pdf2htmlex wvware argon2)
endif()
set(pugixml_FIND_MODE "NO_MODULE")
set(cryptopp_FIND_MODE "NO_MODULE")
set(miniz_FIND_MODE "NO_MODULE")
set(uchardet_FIND_MODE "NO_MODULE")
set(pdf2htmlex_FIND_MODE "NO_MODULE")
set(wvware_FIND_MODE "NO_MODULE")
set(argon2_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(odrcore_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/odrco83ed2e47db1bd/p")
set(odrcore_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(odrcore_INCLUDE_DIRS_RELWITHDEBINFO "${odrcore_PACKAGE_FOLDER_RELWITHDEBINFO}/include")
set(odrcore_RES_DIRS_RELWITHDEBINFO )
set(odrcore_DEFINITIONS_RELWITHDEBINFO )
set(odrcore_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(odrcore_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(odrcore_OBJECTS_RELWITHDEBINFO )
set(odrcore_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(odrcore_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(odrcore_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(odrcore_LIB_DIRS_RELWITHDEBINFO "${odrcore_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(odrcore_BIN_DIRS_RELWITHDEBINFO )
set(odrcore_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(odrcore_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(odrcore_LIBS_RELWITHDEBINFO odr)
set(odrcore_SYSTEM_LIBS_RELWITHDEBINFO )
set(odrcore_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(odrcore_FRAMEWORKS_RELWITHDEBINFO )
set(odrcore_BUILD_DIRS_RELWITHDEBINFO )
set(odrcore_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(odrcore_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${odrcore_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${odrcore_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(odrcore_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${odrcore_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${odrcore_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${odrcore_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(odrcore_COMPONENTS_RELWITHDEBINFO )