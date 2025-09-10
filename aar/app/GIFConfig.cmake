########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(GIF_FIND_QUIETLY)
    set(GIF_MESSAGE_MODE VERBOSE)
else()
    set(GIF_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/GIFTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${giflib_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(GIF_VERSION_STRING "5.2.2")
set(GIF_INCLUDE_DIRS ${giflib_INCLUDE_DIRS_RELWITHDEBINFO} )
set(GIF_INCLUDE_DIR ${giflib_INCLUDE_DIRS_RELWITHDEBINFO} )
set(GIF_LIBRARIES ${giflib_LIBRARIES_RELWITHDEBINFO} )
set(GIF_DEFINITIONS ${giflib_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${giflib_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${GIF_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


