########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(pdf2htmlex_FIND_QUIETLY)
    set(pdf2htmlex_MESSAGE_MODE VERBOSE)
else()
    set(pdf2htmlex_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/pdf2htmlexTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${pdf2htmlex_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(pdf2htmlex_VERSION_STRING "0.18.8.rc1-odr-git-eb5d291")
set(pdf2htmlex_INCLUDE_DIRS ${pdf2htmlex_INCLUDE_DIRS_RELWITHDEBINFO} )
set(pdf2htmlex_INCLUDE_DIR ${pdf2htmlex_INCLUDE_DIRS_RELWITHDEBINFO} )
set(pdf2htmlex_LIBRARIES ${pdf2htmlex_LIBRARIES_RELWITHDEBINFO} )
set(pdf2htmlex_DEFINITIONS ${pdf2htmlex_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${pdf2htmlex_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${pdf2htmlex_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


