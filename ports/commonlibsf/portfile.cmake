vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO Starfield-Reverse-Engineering/CommonLibSF
  REF 9e5128012f66a96f5ef640c523c485107ead1d1c
  SHA512 3835a1b839074ddc5b22b7c44d97f9c944f1db1ef57b4100d95b7b9913763ef7082fe6dca8cbf6d1f993ca46f7adbbe80962c18f62b0ed86fecd16949586d4e0
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
