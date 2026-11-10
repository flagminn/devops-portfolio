#!/bin/bash

EXEC="./src/build/DO"
FAILURES=0

echo "=== START INTEGRATION TESTS ==="

run_test() {
    ARG=$1
    EXPECTED=$2
    
    OUTPUT=$($EXEC "$ARG" 2>&1)
    
    if [[ "$OUTPUT" == *"$EXPECTED"* ]]; then
        echo "[SUCCESS] Input: '$ARG' -> Output contains: '$EXPECTED'"
    else
        echo "[FAILED] Input: '$ARG' -> Expected: '$EXPECTED', Got: '$OUTPUT'"
        FAILURES=$((FAILURES + 1))
    fi
}

run_test "1" "Learning to Linux"
run_test "2" "Learning to work with Network"
run_test "3" "Learning to Monitoring"
run_test "4" "Learning to extra Monitoring"
run_test "5" "Learning to Docker"
run_test "6" "Learning to CI/CD"
run_test "99" "Bad number!"

echo "==============================="

if [ $FAILURES -eq 0 ]; then
    echo "SUCCESS: ALL INTEGRATION TESTS PASSED!"
    exit 0
else
    echo "ERROR: $FAILURES INTEGRATION TEST(S) FAILED!"
    exit 1
fi