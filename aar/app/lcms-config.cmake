########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(lcms_FIND_QUIETLY)
    set(lcms_MESSAGE_MODE VERBOSE)
else()
    set(lcms_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/lcmsTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${lcms_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(lcms_VERSION_STRING "2.16")
set(lcms_INCLUDE_DIRS ${lcms_INCLUDE_DIRS_RELWITHDEBINFO} )
set(lcms_INCLUDE_DIR ${lcms_INCLUDE_DIRS_RELWITHDEBINFO} )
set(lcms_LIBRARIES ${lcms_LIBRARIES_RELWITHDEBINFO} )
set(lcms_DEFINITIONS ${lcms_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${lcms_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${lcms_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


