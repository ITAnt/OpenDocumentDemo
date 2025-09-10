# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/lzo-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${lzo_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${lzo_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET lzo::lzo)
    add_library(lzo::lzo INTERFACE IMPORTED)
    message(${lzo_MESSAGE_MODE} "Conan: Target declared 'lzo::lzo'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/lzo-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()