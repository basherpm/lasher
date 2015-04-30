load lib/assertions

export LASHER_TEST_DIR="${BATS_TMPDIR}/lasher"
export LASHER_TMP_BIN="${LASHER_TEST_DIR}/bin"
export LASHER_CWD="${LASHER_TEST_DIR}/cwd"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
export PATH="${LASHER_TMP_BIN}:$PATH"

mkdir -p "${LASHER_TMP_BIN}"
mkdir -p "${LASHER_TEST_DIR}"
mkdir -p "${LASHER_CWD}"

setup() {
  cd "${LASHER_CWD}"
}

teardown() {
  rm -rf "${LASHER_TEST_DIR}"
}
