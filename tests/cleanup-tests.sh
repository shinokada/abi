#!/usr/bin/env bash

# Clean up old/broken test files
# Keep only the working versions

cd "$(dirname "$0")"

echo "Cleaning up test directory..."
echo ""

# Remove old broken files
if [[ -f "test-abi-simple.sh" ]]; then
    rm test-abi-simple.sh
    echo "✓ Removed test-abi-simple.sh (replaced by test-abi.sh)"
fi

if [[ -f "debug-test.sh" ]]; then
    rm debug-test.sh
    echo "✓ Removed debug-test.sh (no longer needed)"
fi

echo ""
echo "Test directory cleaned!"
echo ""
echo "Remaining files:"
ls -1
echo ""
echo "You can now run:"
echo "  ./test-abi.sh    # Run test suite"
echo "  ./verify.sh      # Quick verification"
