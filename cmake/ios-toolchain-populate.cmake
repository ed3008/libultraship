# leetal/ios-cmake target selection. OS64COMBINED (device + simulator in one
# fat build) is the default because it is convenient, but it is Xcode-only —
# the toolchain hard-fails on any COMBINED platform under another generator.
# Leave it overridable so a caller can pick a single-slice target (OS64,
# SIMULATORARM64, ...) and build with Ninja, which also drops the x86_64
# simulator slice nobody needs on an Apple Silicon host.
if (NOT DEFINED PLATFORM)
    set(PLATFORM "OS64COMBINED")
endif()
include(FetchContent)
FetchContent_Declare(iostoolchain
    GIT_REPOSITORY https://github.com/leetal/ios-cmake
    GIT_TAG 06465b27698424cf4a04a5ca4904d50a3c966c45
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_GetProperties(iostoolchain)
if(NOT iostoolchain_POPULATED)
    FetchContent_Populate(iostoolchain)
endif()
set(CMAKE_IOS_TOOLCHAIN_FILE ${iostoolchain_SOURCE_DIR}/ios.toolchain.cmake)
set_property(GLOBAL PROPERTY IOS_TOOLCHAIN_FILE ${CMAKE_IOS_TOOLCHAIN_FILE})
include(${CMAKE_IOS_TOOLCHAIN_FILE})