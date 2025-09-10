# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/poppler-data-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${poppler-data_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${poppler-data_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET poppler-data::poppler-data)
    add_library(poppler-data::poppler-data INTERFACE IMPORTED)
    message(${poppler-data_MESSAGE_MODE} "Conan: Target declared 'poppler-data::poppler-data'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/poppler-data-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()