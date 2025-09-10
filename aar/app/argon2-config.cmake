########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(argon2_FIND_QUIETLY)
    set(argon2_MESSAGE_MODE VERBOSE)
else()
    set(argon2_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/argon2Targets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${argon2_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(argon2_VERSION_STRING "20190702-odr")
set(argon2_INCLUDE_DIRS ${argon2_INCLUDE_DIRS_RELWITHDEBINFO} )
set(argon2_INCLUDE_DIR ${argon2_INCLUDE_DIRS_RELWITHDEBINFO} )
set(argon2_LIBRARIES ${argon2_LIBRARIES_RELWITHDEBINFO} )
set(argon2_DEFINITIONS ${argon2_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${argon2_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${argon2_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


