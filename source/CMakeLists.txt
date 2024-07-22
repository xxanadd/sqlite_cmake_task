cmake_minimum_required(VERSION 3.10)

# Название проекта
project(SQLiteLibrary)

# Определяем исходные файлы
set(SOURCES sqlite3.c)

# Устанавливаем папку для логов
set(CMAKE_LOG_FILE "cmake.log")
set(CMAKE_LOG_DIR "${CMAKE_BINARY_DIR}/logs")

# Настройки для Windows
if(WIN32)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(ARCH "x64")
    else()
        set(ARCH "x86")
    endif()
    message(STATUS "Building for Windows ${ARCH}")
    add_library(SQLiteLibrary SHARED ${SOURCES})
    set_target_properties(SQLiteLibrary PROPERTIES
            OUTPUT_NAME "sqlite3"
            PREFIX ""
    )
    target_compile_definitions(SQLiteLibrary PRIVATE "SQLITE_EXPORTS")

    # Указываем использование только MSVC
    if(NOT MSVC)
        message(FATAL_ERROR "Only MSVC compiler is supported")
    endif()
    target_compile_options(SQLiteLibrary PRIVATE /W4)

# Настройки для Linux
elseif(UNIX)
    set(CMAKE_C_COMPILER "gcc")
    set(BUILD_SHARED_LIBS ON)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(ARCH "x64")
    else()
        set(ARCH "x86")
    endif()
    message(STATUS "Building for Linux ${ARCH}")
    add_library(SQLiteLibrary SHARED ${SOURCES})
    set_target_properties(SQLiteLibrary PROPERTIES
        OUTPUT_NAME "sqlite3"
    )
    target_compile_options(SQLiteLibrary PRIVATE -Wall -Wextra -Wpedantic -fPIC)

    # Линковка с необходимыми библиотеками
    target_link_libraries(SQLiteLibrary PRIVATE pthread dl)
endif()
