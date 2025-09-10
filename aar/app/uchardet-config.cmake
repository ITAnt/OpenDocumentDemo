########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(uchardet_FIND_QUIETLY)
    set(uchardet_MESSAGE_MODE VERBOSE)
else()
    set(uchardet_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/uchardetTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${uchardet_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(uchardet_VERSION_STRING "0.0.8")
set(uchardet_INCLUDE_DIRS ${uchardet_INCLUDE_DIRS_RELWITHDEBINFO} )
set(uchardet_INCLUDE_DIR ${uchardet_INCLUDE_DIRS_RELWITHDEBINFO} )
set(uchardet_LIBRARIES ${uchardet_LIBRARIES_RELWITHDEBINFO} )
set(uchardet_DEFINITIONS ${uchardet_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${uchardet_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${uchardet_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


