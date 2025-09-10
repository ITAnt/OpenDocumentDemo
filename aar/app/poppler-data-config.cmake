########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(poppler-data_FIND_QUIETLY)
    set(poppler-data_MESSAGE_MODE VERBOSE)
else()
    set(poppler-data_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/poppler-dataTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${poppler-data_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(poppler-data_VERSION_STRING "0.4.12-odr")
set(poppler-data_INCLUDE_DIRS ${poppler-data_INCLUDE_DIRS_RELWITHDEBINFO} )
set(poppler-data_INCLUDE_DIR ${poppler-data_INCLUDE_DIRS_RELWITHDEBINFO} )
set(poppler-data_LIBRARIES ${poppler-data_LIBRARIES_RELWITHDEBINFO} )
set(poppler-data_DEFINITIONS ${poppler-data_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${poppler-data_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${poppler-data_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


