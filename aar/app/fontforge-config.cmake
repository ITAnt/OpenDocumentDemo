########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(fontforge_FIND_QUIETLY)
    set(fontforge_MESSAGE_MODE VERBOSE)
else()
    set(fontforge_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/fontforgeTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${fontforge_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(fontforge_VERSION_STRING "20240423-git")
set(fontforge_INCLUDE_DIRS ${fontforge_INCLUDE_DIRS_RELWITHDEBINFO} )
set(fontforge_INCLUDE_DIR ${fontforge_INCLUDE_DIRS_RELWITHDEBINFO} )
set(fontforge_LIBRARIES ${fontforge_LIBRARIES_RELWITHDEBINFO} )
set(fontforge_DEFINITIONS ${fontforge_DEFINITIONS_RELWITHDEBINFO} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${fontforge_BUILD_MODULES_PATHS_RELWITHDEBINFO} )
    message(${fontforge_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


