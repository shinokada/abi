#!/usr/bin/env bash

# Fix permissions for abi project files
# Run this after cloning or if permissions are lost during editing

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1

echo "Fixing permissions for abi project..."
echo ""

# Make main script executable
if [[ -f "${SCRIPT_DIR}/abi" ]]; then
    chmod +x "${SCRIPT_DIR}/abi"
    echo "✓ Made abi executable"
else
    echo "✗ abi not found"
    exit 1
fi

# Make test scripts executable
if [[ -f "${SCRIPT_DIR}/tests/test-abi.sh" ]]; then
    chmod +x "${SCRIPT_DIR}/tests/test-abi.sh"
    echo "✓ Made tests/test-abi.sh executable"
fi

if [[ -f "${SCRIPT_DIR}/tests/verify.sh" ]]; then
    chmod +x "${SCRIPT_DIR}/tests/verify.sh"
    echo "✓ Made tests/verify.sh executable"
fi

# Make pre-commit hook executable if installed
if [[ -f "${SCRIPT_DIR}/.git/hooks/pre-commit" ]]; then
    chmod +x "${SCRIPT_DIR}/.git/hooks/pre-commit"
    echo "✓ Made .git/hooks/pre-commit executable"
fi

echo ""
echo "✓ All permissions fixed!"
echo ""
echo "You can now run:"
echo "  ./abi --version"
echo "  ./tests/test-abi.sh"
echo "  ./tests/verify.sh"
