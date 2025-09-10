########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(odrcore_FIND_QUIETLY)
    set(odrcore_MESSAGE_MODE VERBOSE)
else()
    set(odrcore_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/odrcoreTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${odrcore_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(odrcore_VERSION_STRING "5.0.4")
set(odrcore_INCLUDE_DIRS ${odrcore_INCLUDE_DIRS_RELWITHDEBINFO} )
set(odrcore_INCLUDE_DIR ${odrcore_INCLUDE_DIRS_RELWITHDEBINFO} )
set(odrcore_LIBRARIES ${odrcore_LIBRARIES_RELWITHDEBINFO} )
set(odrcore_DEFINITIONS ${odrcore_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${odrcore_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${odrcore_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


