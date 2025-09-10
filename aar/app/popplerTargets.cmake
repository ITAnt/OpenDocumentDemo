# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/poppler-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${poppler_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${poppler_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET poppler::poppler)
    add_library(poppler::poppler INTERFACE IMPORTED)
    message(${poppler_MESSAGE_MODE} "Conan: Target declared 'poppler::poppler'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/poppler-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()