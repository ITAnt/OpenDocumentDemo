########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(lzo_FIND_QUIETLY)
    set(lzo_MESSAGE_MODE VERBOSE)
else()
    set(lzo_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/lzoTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${lzo_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(lzo_VERSION_STRING "2.10")
set(lzo_INCLUDE_DIRS ${lzo_INCLUDE_DIRS_RELWITHDEBINFO} )
set(lzo_INCLUDE_DIR ${lzo_INCLUDE_DIRS_RELWITHDEBINFO} )
set(lzo_LIBRARIES ${lzo_LIBRARIES_RELWITHDEBINFO} )
set(lzo_DEFINITIONS ${lzo_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${lzo_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${lzo_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


