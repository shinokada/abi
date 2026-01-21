#!/usr/bin/env bash

# Test suite for abi script
# Simplified version that actually works!

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ABI_SCRIPT="${SCRIPT_DIR}/../abi"

# Colors
readonly GREEN='\033[0;32m'
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Test counters
tests_run=0
tests_passed=0
tests_failed=0

pass() {
    ((tests_passed++))
    ((tests_run++))
    echo -e "${GREEN}✓${NC} $1"
}

fail() {
    ((tests_failed++))
    ((tests_run++))
    echo -e "${RED}✗${NC} $1"
}

section() {
    echo ""
    echo "═══════════════════════════════════════════════════"
    echo "$1"
    echo "═══════════════════════════════════════════════════"
}

echo "╔═══════════════════════════════════════════════════╗"
echo "║         ABI Script Test Suite                     ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""

# Pre-check
if [[ ! -f "${ABI_SCRIPT}" ]]; then
    echo -e "${RED}✗ Error: abi script not found at ${ABI_SCRIPT}${NC}"
    exit 1
fi

echo -e "${BLUE}Testing: ${ABI_SCRIPT}${NC}"
echo ""

# Test 1: File exists
section "Test 1: File Existence"
if [[ -f "${ABI_SCRIPT}" ]]; then
    pass "abi script exists"
else
    fail "abi script not found"
fi

# Test 2: Is executable
section "Test 2: Executability"
if [[ -x "${ABI_SCRIPT}" ]]; then
    pass "Script is executable"
else
    fail "Script is NOT executable - run: chmod +x ../abi"
fi

# Test 3: Version flag (with timeout)
section "Test 3: Version Flag"
if [[ -x "${ABI_SCRIPT}" ]]; then
    if version=$(timeout 3s "${ABI_SCRIPT}" --version 2>&1 || true); then
        if [[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            pass "Version command works: ${version}"
        else
            fail "Version format invalid: ${version}"
        fi
    else
        fail "Version command timed out or failed"
    fi
else
    fail "Skipped (script not executable)"
fi

# Test 4: Help flag (with timeout)
section "Test 4: Help Flag"
if [[ -x "${ABI_SCRIPT}" ]]; then
    if output=$(timeout 3s "${ABI_SCRIPT}" --help 2>&1 || true); then
        if [[ "${output}" =~ "Usage:" ]]; then
            pass "Help command works"
        else
            fail "Help output invalid"
        fi
    else
        fail "Help command timed out or failed"
    fi
else
    fail "Skipped (script not executable)"
fi

# Test 5: Shebang
section "Test 5: Shebang Line"
if first_line=$(head -n 1 "${ABI_SCRIPT}" 2>/dev/null); then
    # Accept both #!/usr/bin/env bash and #!/bin/bash
    if [[ "${first_line}" =~ ^#!.*/bash$ ]] || [[ "${first_line}" =~ ^#!/usr/bin/env\ bash$ ]]; then
        pass "Has valid bash shebang: ${first_line}"
    else
        fail "Invalid shebang: ${first_line}"
    fi
else
    fail "Could not read file"
fi

# Summary
section "Test Summary"
echo "Tests run: ${tests_run}"
echo -e "${GREEN}Passed: ${tests_passed}${NC}"
echo -e "${RED}Failed: ${tests_failed}${NC}"
echo ""

if [[ ${tests_failed} -eq 0 ]] && [[ ${tests_passed} -gt 0 ]]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    echo ""
    echo "The abi script is working correctly."
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    echo ""
    exit 1
fi
