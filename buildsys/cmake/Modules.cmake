
#must before add_target_link
MACRO(depdent_module _this_name _module_name)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${_module_name}/include)
    #add_dependencies(${_this_name} ${_module_name})
    #set(EXTRA_LINKED_LIBRARIES ${EXTRA_LINKED_LIBRARIES} ${_module_name})
    #set(EXTRA_LINKED_LIBRARIES ${EXTRA_LINKED_LIBRARIES} 
    #debug ${_module_name}${LOO_OUTPUT_SUFFIX}_d optimized ${_module_name}${LOO_OUTPUT_SUFFIX}
    #)
    set(EXTRA_LINKED_LIBRARIES ${EXTRA_LINKED_LIBRARIES}  "${_module_name}")
ENDMACRO(depdent_module)

MACRO(dep_module_static  _module_name)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${_module_name}/include)
    #add_dependencies(${MODULE_NAME} ${_module_name})
    #set(EXTRA_LINKED_LIBRARIES ${EXTRA_LINKED_LIBRARIES} 
    #debug ${_module_name}${LOO_OUTPUT_SUFFIX}_d optimized ${_module_name}${LOO_OUTPUT_SUFFIX}
    #)
    set(EXTRA_LINKED_LIBRARIES ${EXTRA_LINKED_LIBRARIES}  "${_module_name}")
ENDMACRO(dep_module_static)


MACRO(add_dep_link_dir)
    #IF(NOT LOO_PLATFORM_WINDOWS_STORE AND NOT LOO_PLATFORM_ANDROID AND NOT LOO_PLATFORM_IOS)
    IF(LOO_PLATFORM_DARWIN OR LOO_PLATFORM_LINUX)
        LINK_DIRECTORIES(${LOO_BIN_DIR})
    ELSE()
        LINK_DIRECTORIES(${LOO_OUTPUT_DIR})
    ENDIF()
ENDMACRO(add_dep_link_dir)
#MODULE_NAME
#MODULE_ERSION
#MODULE_SOVERSION
#SOURCE_PUBLIC
#SOURCE_PRIVATE
#set(MODULE_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})
MACRO(add_module)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/include)
    add_library(${MODULE_NAME} ${LOO_PREFERRED_LIB_TYPE}
    ${SOURCE_PRIVATE} ${SOURCE_PUBLIC}
    )
ENDMACRO(add_module)

MACRO(add_static_module)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/include)
    add_library(${MODULE_NAME} STATIC
    ${SOURCE_PRIVATE} ${SOURCE_PUBLIC}
    )
ENDMACRO(add_static_module)
#declare_module(name,header,source,v0,v1,_folder)
MACRO(declare_module)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/Public)
    #add_library(${MODULE_NAME} ${LOO_PREFERRED_LIB_TYPE}
    # ${SOURCE_PRIVATE} ${SOURCE_PUBLIC}
    #)
    target_compile_definitions( ${MODULE_NAME}  PUBLIC ${LOO_COMPILER_DEFINITIONS} )
    set_target_properties(${MODULE_NAME} PROPERTIES VERSION ${MODULE_ERSION} SOVERSION ${MODULE_SOVERSION})
    set_target_properties(${MODULE_NAME} PROPERTIES 
        PROJECT_LABEL ${MODULE_NAME}
        DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
        OUTPUT_NAME ${MODULE_NAME}${LOO_OUTPUT_SUFFIX}
    )
    set_target_properties(${MODULE_NAME} PROPERTIES 
        ARCHIVE_OUTPUT_DIRECTORY ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_OUTPUT_DIR}
    )

    #For non-DLL platforms shared libraries are treated as library targets. For DLL platforms the DLL part of a shared library is treated as a runtime target and the corresponding import library is treated as an archive target. 
    set_target_properties(${MODULE_NAME} PROPERTIES 
        RUNTIME_OUTPUT_DIRECTORY ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_DEBUG ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_RELEASE ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_BIN_DIR}
    )

    IF(LOO_PLATFORM_DARWIN OR LOO_PLATFORM_LINUX)
        SET_TARGET_PROPERTIES(${MODULE_NAME} PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_DEBUG ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELEASE ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_BIN_DIR})
    ENDIF()
    target_include_directories(${MODULE_NAME}  PUBLIC ${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/include)
    TARGET_LINK_LIBRARIES(${MODULE_NAME}
    ${EXTRA_LINKED_LIBRARIES}
	#debug MeshMLLib${LOO_OUTPUT_SUFFIX}_d optimized MeshMLLib${LOO_OUTPUT_SUFFIX}
    )
    IF(LOO_PLATFORM_WINDOWS)
        ADD_POST_BUILD(${MODULE_NAME} "")
        INSTALL(TARGETS ${MODULE_NAME}
            RUNTIME DESTINATION ${LOO_BIN_DIR}
            LIBRARY DESTINATION ${LOO_BIN_DIR}
            ARCHIVE DESTINATION ${LOO_OUTPUT_DIR}
        )
    ENDIF()
    SET_TARGET_PROPERTIES(${MODULE_NAME} PROPERTIES FOLDER "${FOLDER_PATH}")
    ADD_DEPENDENCIES(AllInEngine ${MODULE_NAME})
ENDMACRO(declare_module)

# 不知道其他平台能不能这样，这是为了解决模板与dll的问题
MACRO(declare_module_static)
    #INCLUDE_DIRECTORIES(${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/Public)
    #add_library(${MODULE_NAME} STATIC
    # ${SOURCE_PRIVATE} ${SOURCE_PUBLIC}
    #)
    target_compile_definitions( ${MODULE_NAME}  PUBLIC ${LOO_COMPILER_DEFINITIONS} )
    set_target_properties(${MODULE_NAME} PROPERTIES VERSION ${MODULE_ERSION} SOVERSION ${MODULE_SOVERSION})
    set_target_properties(${MODULE_NAME} PROPERTIES 
    PROJECT_LABEL ${MODULE_NAME}
    DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
    OUTPUT_NAME ${MODULE_NAME}${LOO_OUTPUT_SUFFIX}
    )
    set_target_properties(${MODULE_NAME} PROPERTIES 
        ARCHIVE_OUTPUT_DIRECTORY ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_OUTPUT_DIR}
        ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_OUTPUT_DIR}
    )

    #For non-DLL platforms shared libraries are treated as library targets. For DLL platforms the DLL part of a shared library is treated as a runtime target and the corresponding import library is treated as an archive target. 
    set_target_properties(${MODULE_NAME} PROPERTIES 
        RUNTIME_OUTPUT_DIRECTORY ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_DEBUG ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_RELEASE ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_BIN_DIR}
        RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_BIN_DIR}
    )

    IF(LOO_PLATFORM_DARWIN OR LOO_PLATFORM_LINUX)
        SET_TARGET_PROPERTIES(${MODULE_NAME} PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_DEBUG ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELEASE ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${LOO_BIN_DIR}
            LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${LOO_BIN_DIR})
    ENDIF()
    target_include_directories(${MODULE_NAME}  PUBLIC ${LOO_RUNTIME_ROOT_DIR}/${MODULE_NAME}/include)
    TARGET_LINK_LIBRARIES(${MODULE_NAME}
    ${EXTRA_LINKED_LIBRARIES}
	#debug MeshMLLib${LOO_OUTPUT_SUFFIX}_d optimized MeshMLLib${LOO_OUTPUT_SUFFIX}
    )
    IF(LOO_PLATFORM_WINDOWS)
        ADD_POST_BUILD(${MODULE_NAME} "")
        INSTALL(TARGETS ${MODULE_NAME}
            RUNTIME DESTINATION ${LOO_BIN_DIR}
            LIBRARY DESTINATION ${LOO_BIN_DIR}
            ARCHIVE DESTINATION ${LOO_OUTPUT_DIR}
        )
    ENDIF()

    SET_TARGET_PROPERTIES(${MODULE_NAME} PROPERTIES FOLDER "${FOLDER_PATH}")
    ADD_DEPENDENCIES(AllInEngine ${MODULE_NAME})
ENDMACRO(declare_module_static)

MACRO(set_module_version _module_name MODULE_ERSION MODULE_SOVERSION)
    set_target_properties(${_module_name} PROPERTIES VERSION ${MODULE_ERSION} SOVERSION ${MODULE_SOVERSION})
ENDMACRO(set_module_version)

