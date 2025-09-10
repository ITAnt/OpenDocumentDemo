########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND poppler_COMPONENT_NAMES poppler::libpoppler poppler::libpoppler-cpp poppler::libpoppler-splash poppler::libpoppler-cairo poppler::libpoppler-glib)
list(REMOVE_DUPLICATES poppler_COMPONENT_NAMES)
if(DEFINED poppler_FIND_DEPENDENCY_NAMES)
  list(APPEND poppler_FIND_DEPENDENCY_NAMES poppler-data OpenJPEG lcms cairo Fontconfig freetype JPEG glib PNG ZLIB Iconv)
  list(REMOVE_DUPLICATES poppler_FIND_DEPENDENCY_NAMES)
else()
  set(poppler_FIND_DEPENDENCY_NAMES poppler-data OpenJPEG lcms cairo Fontconfig freetype JPEG glib PNG ZLIB Iconv)
endif()
set(poppler-data_FIND_MODE "NO_MODULE")
set(OpenJPEG_FIND_MODE "NO_MODULE")
set(lcms_FIND_MODE "NO_MODULE")
set(cairo_FIND_MODE "NO_MODULE")
set(Fontconfig_FIND_MODE "NO_MODULE")
set(freetype_FIND_MODE "NO_MODULE")
set(JPEG_FIND_MODE "NO_MODULE")
set(glib_FIND_MODE "NO_MODULE")
set(PNG_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")
set(Iconv_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(poppler_PACKAGE_FOLDER_RELWITHDEBINFO "C:/Users/PC/.conan2/p/popplb04ecde07fb86/p")
set(poppler_BUILD_MODULES_PATHS_RELWITHDEBINFO )


set(poppler_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_RES_DIRS_RELWITHDEBINFO )
set(poppler_DEFINITIONS_RELWITHDEBINFO "-DPOPPLER_STATIC")
set(poppler_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_OBJECTS_RELWITHDEBINFO )
set(poppler_COMPILE_DEFINITIONS_RELWITHDEBINFO "POPPLER_STATIC")
set(poppler_COMPILE_OPTIONS_C_RELWITHDEBINFO )
set(poppler_COMPILE_OPTIONS_CXX_RELWITHDEBINFO )
set(poppler_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_BIN_DIRS_RELWITHDEBINFO )
set(poppler_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_LIBS_RELWITHDEBINFO poppler-glib poppler-cpp poppler)
set(poppler_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_BUILD_DIRS_RELWITHDEBINFO )
set(poppler_NO_SONAME_MODE_RELWITHDEBINFO FALSE)


# COMPOUND VARIABLES
set(poppler_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
set(poppler_LINKER_FLAGS_RELWITHDEBINFO
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_SHARED_LINK_FLAGS_RELWITHDEBINFO}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_EXE_LINK_FLAGS_RELWITHDEBINFO}>")


set(poppler_COMPONENTS_RELWITHDEBINFO poppler::libpoppler poppler::libpoppler-cpp poppler::libpoppler-splash poppler::libpoppler-cairo poppler::libpoppler-glib)
########### COMPONENT poppler::libpoppler-glib VARIABLES ############################################

set(poppler_poppler_libpoppler-glib_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_poppler_libpoppler-glib_BIN_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_poppler_libpoppler-glib_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_poppler_libpoppler-glib_RES_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_OBJECTS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-glib_LIBS_RELWITHDEBINFO poppler-glib)
set(poppler_poppler_libpoppler-glib_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_DEPENDENCIES_RELWITHDEBINFO poppler::libpoppler-cairo glib::glib)
set(poppler_poppler_libpoppler-glib_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-glib_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(poppler_poppler_libpoppler-glib_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_poppler_libpoppler-glib_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_poppler_libpoppler-glib_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_poppler_libpoppler-glib_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_poppler_libpoppler-glib_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT poppler::libpoppler-cairo VARIABLES ############################################

set(poppler_poppler_libpoppler-cairo_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_poppler_libpoppler-cairo_BIN_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_poppler_libpoppler-cairo_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_poppler_libpoppler-cairo_RES_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_OBJECTS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-cairo_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_DEPENDENCIES_RELWITHDEBINFO poppler::libpoppler cairo::cairo)
set(poppler_poppler_libpoppler-cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cairo_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(poppler_poppler_libpoppler-cairo_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_poppler_libpoppler-cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_poppler_libpoppler-cairo_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_poppler_libpoppler-cairo_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_poppler_libpoppler-cairo_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT poppler::libpoppler-splash VARIABLES ############################################

set(poppler_poppler_libpoppler-splash_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_poppler_libpoppler-splash_BIN_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_poppler_libpoppler-splash_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_poppler_libpoppler-splash_RES_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_OBJECTS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-splash_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_DEPENDENCIES_RELWITHDEBINFO poppler::libpoppler)
set(poppler_poppler_libpoppler-splash_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-splash_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(poppler_poppler_libpoppler-splash_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_poppler_libpoppler-splash_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_poppler_libpoppler-splash_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_poppler_libpoppler-splash_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_poppler_libpoppler-splash_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT poppler::libpoppler-cpp VARIABLES ############################################

set(poppler_poppler_libpoppler-cpp_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_poppler_libpoppler-cpp_BIN_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_poppler_libpoppler-cpp_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_poppler_libpoppler-cpp_RES_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_OBJECTS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler-cpp_LIBS_RELWITHDEBINFO poppler-cpp)
set(poppler_poppler_libpoppler-cpp_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_DEPENDENCIES_RELWITHDEBINFO poppler::libpoppler Iconv::Iconv)
set(poppler_poppler_libpoppler-cpp_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler-cpp_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(poppler_poppler_libpoppler-cpp_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_poppler_libpoppler-cpp_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_poppler_libpoppler-cpp_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_poppler_libpoppler-cpp_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_poppler_libpoppler-cpp_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")
########### COMPONENT poppler::libpoppler VARIABLES ############################################

set(poppler_poppler_libpoppler_INCLUDE_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_LIB_DIRS_RELWITHDEBINFO "${poppler_PACKAGE_FOLDER_RELWITHDEBINFO}/lib")
set(poppler_poppler_libpoppler_BIN_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_LIBRARY_TYPE_RELWITHDEBINFO STATIC)
set(poppler_poppler_libpoppler_IS_HOST_WINDOWS_RELWITHDEBINFO 0)
set(poppler_poppler_libpoppler_RES_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_DEFINITIONS_RELWITHDEBINFO "-DPOPPLER_STATIC")
set(poppler_poppler_libpoppler_OBJECTS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_COMPILE_DEFINITIONS_RELWITHDEBINFO "POPPLER_STATIC")
set(poppler_poppler_libpoppler_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(poppler_poppler_libpoppler_LIBS_RELWITHDEBINFO poppler)
set(poppler_poppler_libpoppler_SYSTEM_LIBS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_FRAMEWORKS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_DEPENDENCIES_RELWITHDEBINFO poppler-data::poppler-data Freetype::Freetype Fontconfig::Fontconfig openjp2 lcms::lcms JPEG::JPEG PNG::PNG ZLIB::ZLIB)
set(poppler_poppler_libpoppler_SHARED_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_EXE_LINK_FLAGS_RELWITHDEBINFO )
set(poppler_poppler_libpoppler_NO_SONAME_MODE_RELWITHDEBINFO FALSE)

# COMPOUND VARIABLES
set(poppler_poppler_libpoppler_LINKER_FLAGS_RELWITHDEBINFO
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${poppler_poppler_libpoppler_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${poppler_poppler_libpoppler_SHARED_LINK_FLAGS_RELWITHDEBINFO}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${poppler_poppler_libpoppler_EXE_LINK_FLAGS_RELWITHDEBINFO}>
)
set(poppler_poppler_libpoppler_COMPILE_OPTIONS_RELWITHDEBINFO
    "$<$<COMPILE_LANGUAGE:CXX>:${poppler_poppler_libpoppler_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>"
    "$<$<COMPILE_LANGUAGE:C>:${poppler_poppler_libpoppler_COMPILE_OPTIONS_C_RELWITHDEBINFO}>")