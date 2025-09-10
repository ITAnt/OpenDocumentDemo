# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/odrcore-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${odrcore_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${odrcore_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET odrcore::odrcore)
    add_library(odrcore::odrcore INTERFACE IMPORTED)
    message(${odrcore_MESSAGE_MODE} "Conan: Target declared 'odrcore::odrcore'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/odrcore-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()