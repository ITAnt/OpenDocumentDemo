# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/pdf2htmlex-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${pdf2htmlex_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${pdf2htmlex_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET pdf2htmlex::pdf2htmlex)
    add_library(pdf2htmlex::pdf2htmlex INTERFACE IMPORTED)
    message(${pdf2htmlex_MESSAGE_MODE} "Conan: Target declared 'pdf2htmlex::pdf2htmlex'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/pdf2htmlex-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()