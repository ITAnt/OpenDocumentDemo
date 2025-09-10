########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(wvware_FIND_QUIETLY)
    set(wvware_MESSAGE_MODE VERBOSE)
else()
    set(wvware_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/wvwareTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${wvware_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(wvware_VERSION_STRING "1.2.9-odr")
set(wvware_INCLUDE_DIRS ${wvware_INCLUDE_DIRS_RELWITHDEBINFO} )
set(wvware_INCLUDE_DIR ${wvware_INCLUDE_DIRS_RELWITHDEBINFO} )
set(wvware_LIBRARIES ${wvware_LIBRARIES_RELWITHDEBINFO} )
set(wvware_DEFINITIONS ${wvware_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${wvware_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${wvware_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


