########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(pixman_FIND_QUIETLY)
    set(pixman_MESSAGE_MODE VERBOSE)
else()
    set(pixman_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/pixmanTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${pixman_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(pixman_VERSION_STRING "0.43.4")
set(pixman_INCLUDE_DIRS ${pixman_INCLUDE_DIRS_RELWITHDEBINFO} )
set(pixman_INCLUDE_DIR ${pixman_INCLUDE_DIRS_RELWITHDEBINFO} )
set(pixman_LIBRARIES ${pixman_LIBRARIES_RELWITHDEBINFO} )
set(pixman_DEFINITIONS ${pixman_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${pixman_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${pixman_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


