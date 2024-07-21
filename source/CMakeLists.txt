cmake_minimum_required(VERSION 3.10)

# Название проекта
project(SQLiteLibrary)

# Определяем исходные файлы
set(SOURCES sqlite3.c)

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

    # Указываем использование MSVC
    if (MSVC)
        target_compile_options(SQLiteLibrary PRIVATE /W4)
    endif()

# Настройки для Linux
elseif(UNIX)
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

    # Указываем использование GCC
    if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
        target_compile_options(SQLiteLibrary PRIVATE -Wall -Wextra -Wpedantic -fPIC)
    endif()

    # Линковка с необходимыми библиотеками
    target_link_libraries(SQLiteLibrary PRIVATE pthread dl)
endif()
