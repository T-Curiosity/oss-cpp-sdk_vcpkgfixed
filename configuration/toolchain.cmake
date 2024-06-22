# 如果 VCPKG_ROOT_DIR 已定义，使用它
if(DEFINED VCPKG_ROOT_DIR)
    set(VCPKG_ROOT "${VCPKG_ROOT_DIR}")
    message(STATUS "VCPKG_ROOT_DIR: ${VCPKG_ROOT_DIR}")

# 否则检查 VCPKG_ROOT 环境变量
elseif(DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
    message(STATUS "VCPKG_ROOT: $ENV{VCPKG_ROOT}")

# 如果两者都未定义，报告错误
else()
    message(FATAL_ERROR "Environment variable VCPKG_ROOT is not defined and VCPKG_ROOT_DIR is not set.")
endif()

# 确保 CMAKE_TOOLCHAIN_FILE 使用正确的 vcpkg 工具链文件路径
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "Vcpkg toolchain file")




