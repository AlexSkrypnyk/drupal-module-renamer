#!/usr/bin/env bats
#
# Test for assets.
#
# shellcheck disable=SC2030,SC2031,SC2129

load _helper

setup() {
  export CUR_DIR="$(pwd)"

  # Root build directory where all fixture directories are located.
  export BUILD_DIR="${BUILD_DIR:-"${BATS_TEST_TMPDIR}/drupal-module-renamer-$(random_string)"}"

  # Fixture directory for bats fixtures.
  export FIXTURE_DIR="${BUILD_DIR}/bats-fixture"

  prepare_fixture_dir "${BUILD_DIR}"
  prepare_fixture_dir "${FIXTURE_DIR}"
  cp -Rf "${CUR_DIR}/tests/fixtures/." "${FIXTURE_DIR}/"

  echo "BUILD_DIR dir: ${BUILD_DIR}" >&3
}

@test "Rename" {
  assert_dir_exists "${FIXTURE_DIR}/ys_core"
  assert_file_exists "${FIXTURE_DIR}/ys_core/ys_core.info.yml"
  assert_file_exists "${FIXTURE_DIR}/ys_core/ys_core.install"
  assert_file_exists "${FIXTURE_DIR}/ys_core/ys_core.module"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Unit/YsCoreExampleUnitTest.php"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Unit/YsCoreUnitTestBase.php"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Kernel/YsCoreExampleKernelTest.php"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Kernel/YsCoreKernelTestBase.php"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Functional/YsCoreExampleFunctionalTest.php"
  assert_file_exists "${FIXTURE_DIR}/ys_core/tests/src/Functional/YsCoreFunctionalTestBase.php"

  assert_file_contains "${FIXTURE_DIR}/ys_core/ys_core.module" "ys_core_mail_alter"
  assert_file_contains "${FIXTURE_DIR}/ys_core/ys_core.module" "_ys_core_attach_livereload"
  assert_file_contains "${FIXTURE_DIR}/ys_core/ys_core.install" "ys_core_install"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Unit/YsCoreExampleUnitTest.php" "YsCoreExampleUnitTest"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Unit/YsCoreUnitTestBase.php" "YsCoreUnitTestBase"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Kernel/YsCoreExampleKernelTest.php" "YsCoreExampleKernelTest"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Kernel/YsCoreKernelTestBase.php" "YsCoreKernelTestBase"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Functional/YsCoreExampleFunctionalTest.php" "YsCoreExampleFunctionalTest"
  assert_file_contains "${FIXTURE_DIR}/ys_core/tests/src/Functional/YsCoreFunctionalTestBase.php" "YsCoreFunctionalTestBase"

  run ./drupal-module-renamer.sh "${FIXTURE_DIR}" "ys_core" "Ys" "sw_core" "Sw"
  assert_success

  assert_output_contains "${FIXTURE_DIR}"

  assert_dir_exists "${FIXTURE_DIR}/sw_core"
  assert_file_exists "${FIXTURE_DIR}/sw_core/sw_core.info.yml"
  assert_file_exists "${FIXTURE_DIR}/sw_core/sw_core.install"
  assert_file_exists "${FIXTURE_DIR}/sw_core/sw_core.module"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Unit/SwCoreExampleUnitTest.php"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Unit/SwCoreUnitTestBase.php"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Kernel/SwCoreExampleKernelTest.php"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Kernel/SwCoreKernelTestBase.php"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Functional/SwCoreExampleFunctionalTest.php"
  assert_file_exists "${FIXTURE_DIR}/sw_core/tests/src/Functional/SwCoreFunctionalTestBase.php"

  assert_file_contains "${FIXTURE_DIR}/sw_core/sw_core.module" "sw_core_mail_alter"
  assert_file_contains "${FIXTURE_DIR}/sw_core/sw_core.module" "_sw_core_attach_livereload"
  assert_file_contains "${FIXTURE_DIR}/sw_core/sw_core.install" "sw_core_install"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Unit/SwCoreExampleUnitTest.php" "SwCoreExampleUnitTest"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Unit/SwCoreUnitTestBase.php" "SwCoreUnitTestBase"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Kernel/SwCoreExampleKernelTest.php" "SwCoreExampleKernelTest"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Kernel/SwCoreKernelTestBase.php" "SwCoreKernelTestBase"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Functional/SwCoreExampleFunctionalTest.php" "SwCoreExampleFunctionalTest"
  assert_file_contains "${FIXTURE_DIR}/sw_core/tests/src/Functional/SwCoreFunctionalTestBase.php" "SwCoreFunctionalTestBase"
}
