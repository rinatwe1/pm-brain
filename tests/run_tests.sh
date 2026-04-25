#!/usr/bin/env bash
# Run all PM Brain tests

set -euo pipefail

TESTS_DIR="$(cd "$(dirname "$0")" && pwd)"
TOTAL_PASS=0
TOTAL_FAIL=0
PRODUCT_DIR="${1:-}"

run_test() {
  local script="$1"
  local name
  name=$(basename "$script" .sh)

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "$name"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  if bash "$script" ${PRODUCT_DIR:+"$PRODUCT_DIR"} 2>&1; then
    RESULT_PASS=$(bash "$script" ${PRODUCT_DIR:+"$PRODUCT_DIR"} 2>&1 | grep "Results:" | grep -o "[0-9]* passed" | grep -o "[0-9]*" || echo 0)
    RESULT_FAIL=$(bash "$script" ${PRODUCT_DIR:+"$PRODUCT_DIR"} 2>&1 | grep "Results:" | grep -o "[0-9]* failed" | grep -o "[0-9]*" || echo 0)
    ((TOTAL_PASS += RESULT_PASS)) || true
    ((TOTAL_FAIL += RESULT_FAIL)) || true
  fi
  echo ""
}

echo ""
echo "PM Brain Test Suite"
echo "═══════════════════"
echo ""

run_test "$TESTS_DIR/test_install.sh"
run_test "$TESTS_DIR/test_skills.sh"

if [ -n "$PRODUCT_DIR" ]; then
  run_test "$TESTS_DIR/test_brain_init_output.sh"
else
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "test_brain_init_output (skipped)"
  echo "  Pass a product dir to run: ./run_tests.sh /path/to/product"
  echo ""
fi

echo "═══════════════════"
echo "Total: $TOTAL_PASS passed, $TOTAL_FAIL failed"
[ $TOTAL_FAIL -eq 0 ] && echo "All tests passed ✓" && exit 0 || echo "Some tests failed ✗" && exit 1
