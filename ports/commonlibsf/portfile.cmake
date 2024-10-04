vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO Starfield-Reverse-Engineering/CommonLibSF
  REF 12acf2ac5a88d871ec1fe8478c1543b3045d633a
  SHA512 901919bcfc017c8fc659477bf3bcd673c931c57b2209e6eb4183fc6dee3c57a689389af1d2cdd02c2f0a56f1f708aa8a25717211853425ca9c24d0b58ad30ff9
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
