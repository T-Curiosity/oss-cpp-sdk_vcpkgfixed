内容仅供参考，谨慎使用

#### 调整了这些内容

添加文件 configuration\toolchain.cmake

```cmake
# 如果 VCPKG_ROOT_DIR 已定义，使用它 加这个的主要原因是在vcpkg 中 install的时候 不多传参了
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
```

###### CMakeLists.txt

```cmake
...

include(configuration/toolchain.cmake)

...

if (${TARGET_OS} STREQUAL "WINDOWS")
# 注释掉了这些内容
#	set(WLIB_TARGET "Win32")
#	if (CMAKE_CL_64)
#	set(WLIB_TARGET "x64")
#	endif()
#	set(CRYPTO_LIBS 
#		${CMAKE_SOURCE_DIR}/third_party/lib/${WLIB_TARGET}/ssleay32.lib 
#		${CMAKE_SOURCE_DIR}/third_party/lib/${WLIB_TARGET}/libeay32.lib)
#	set(CRYPTO_INCLUDE_DIRS 
#		${CMAKE_SOURCE_DIR}/third_party/include) 
#
#	set(CLIENT_LIBS 
#		${CMAKE_SOURCE_DIR}/third_party/lib/${WLIB_TARGET}/libcurl.lib) 
#	set(CLIENT_INCLUDE_DIRS 
#		${CMAKE_SOURCE_DIR}/third_party/include) 

# 增加了这些内容
	find_package(CURL REQUIRED)
	find_package(OpenSSL REQUIRED)

	set(CRYPTO_LIBS ${OPENSSL_LIBRARIES})
	set(CRYPTO_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})

	set(CLIENT_LIBS ${CURL_LIBRARIES})
	set(CLIENT_INCLUDE_DIRS ${CURL_INCLUDE_DIRS})
else()

...


```



