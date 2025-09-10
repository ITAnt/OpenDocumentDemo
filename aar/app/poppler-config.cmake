########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(poppler_FIND_QUIETLY)
    set(poppler_MESSAGE_MODE VERBOSE)
else()
    set(poppler_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/popplerTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${poppler_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(poppler_VERSION_STRING "24.08.0-odr")
set(poppler_INCLUDE_DIRS ${poppler_INCLUDE_DIRS_RELWITHDEBINFO} )
set(poppler_INCLUDE_DIR ${poppler_INCLUDE_DIRS_RELWITHDEBINFO} )
set(poppler_LIBRARIES ${poppler_LIBRARIES_RELWITHDEBINFO} )
set(poppler_DEFINITIONS ${poppler_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${poppler_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${poppler_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


