vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO Starfield-Reverse-Engineering/CommonLibSF
  REF f992968552d43693b8c1b78a7e3f4f256044d9fd
  SHA512 993f15273f0c345f5a99ca04313b658f77d4ad15197cca1d5afdaf6cf98c3665a0812b025919caac1da6fb44a6250d1fb6aca5284674c8ba87c892aa6571718f
  HEAD_REF main
)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
  xbyak SFSE_SUPPORT_XBYAK
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
  PACKAGE_NAME CommonLibSF
  CONFIG_PATH lib/cmake
)

vcpkg_copy_pdbs()

file(GLOB CMAKE_CONFIGS ${CURRENT_PACKAGES_DIR}/share/CommonLibSF/CommonLibSF/*.cmake)

file(
  INSTALL ${CMAKE_CONFIGS}
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/CommonLibSF
)
file(
  INSTALL ${SOURCE_PATH}/cmake/CommonLibSF.cmake
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/CommonLibSF
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/CommonLibSF/CommonLibSF)

file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/COPYING)
