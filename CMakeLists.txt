##TODO Add support for Android
##TODO Add support Linux

cmake_minimum_required(VERSION 3.16)

project(MultyT VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# For ninja output too long error
if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    SET(CMAKE_C_USE_RESPONSE_FILE_FOR_OBJECTS 1)
    SET(CMAKE_CXX_USE_RESPONSE_FILE_FOR_OBJECTS 1)

    SET(CMAKE_C_RESPONSE_FILE_LINK_FLAG "@")
    SET(CMAKE_CXX_RESPONSE_FILE_LINK_FLAG "@")

    SET(CMAKE_NINJA_FORCE_RESPONSE_FILE 1 CACHE INTERNAL "")
endif()

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Quick QuickControls2 LinguistTools)

# Custom qml components
list(APPEND QML_DIRS "${CMAKE_SOURCE_DIR}/resources/qml")
set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Custom qml import paths")
message(QML_IMPORT_PATH ${QML_IMPORT_PATH})

set(TS_FILES
    resources/translations/MultyT_en_US.ts)

set(PROJECT_SOURCES
    src/main.cpp
    src/controllers/GameController.h
    src/controllers/GameController.cpp
    src/data/Logic.h
    src/data/Logic.cpp
    src/data/Record.h
    src/data/Record.cpp
    src/data/Records.h
    src/data/Records.cpp
    resources/res.qrc
    ${TS_FILES}
)

qt_add_executable(MultyT
    MANUAL_FINALIZATION
    ${PROJECT_SOURCES}
)
qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})

target_include_directories(MultyT PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(MultyT PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Quick
    Qt6::QuickControls2
)

 include(GNUInstallDirs)
 install(TARGETS MultyT
     BUNDLE DESTINATION .
     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
 )

qt_import_qml_plugins(MultyT)
qt_finalize_executable(MultyT)
