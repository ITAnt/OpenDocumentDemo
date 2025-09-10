# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/libgsf-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${libgsf_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${libgsf_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET libgsf::libgsf)
    add_library(libgsf::libgsf INTERFACE IMPORTED)
    message(${libgsf_MESSAGE_MODE} "Conan: Target declared 'libgsf::libgsf'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/libgsf-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()