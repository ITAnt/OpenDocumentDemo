########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(libgsf_FIND_QUIETLY)
    set(libgsf_MESSAGE_MODE VERBOSE)
else()
    set(libgsf_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/libgsfTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${libgsf_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(libgsf_VERSION_STRING "1.14.52")
set(libgsf_INCLUDE_DIRS ${libgsf_INCLUDE_DIRS_RELWITHDEBINFO} )
set(libgsf_INCLUDE_DIR ${libgsf_INCLUDE_DIRS_RELWITHDEBINFO} )
set(libgsf_LIBRARIES ${libgsf_LIBRARIES_RELWITHDEBINFO} )
set(libgsf_DEFINITIONS ${libgsf_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${libgsf_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${libgsf_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


