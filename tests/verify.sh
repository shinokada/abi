#!/usr/bin/env bash

# Quick verification script for abi installation
# Checks basic functionality without hanging

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1
readonly SCRIPT_DIR
readonly PROJECT_ROOT="${SCRIPT_DIR}/.."
readonly ABI_SCRIPT="${PROJECT_ROOT}/abi"

# Colors
readonly GREEN='\033[0;32m'
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

checks_passed=0
checks_failed=0

check() {
    if "$@"; then
        ((checks_passed++))
        return 0
    else
        ((checks_failed++))
        return 1
    fi
}

echo "╔═══════════════════════════════════════════════════╗"
echo "║     ABI Installation Verification                 ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""

# Check 1: File exists
echo -e "${BLUE}Checking installation...${NC}"
if [[ -f "${ABI_SCRIPT}" ]]; then
    echo -e "${GREEN}✓${NC} abi script found"
    ((checks_passed++))
else
    echo -e "${RED}✗${NC} abi script NOT found at: ${ABI_SCRIPT}"
    ((checks_failed++))
    exit 1
fi

# Check 2: Is executable
if [[ -x "${ABI_SCRIPT}" ]]; then
    echo -e "${GREEN}✓${NC} abi is executable"
    ((checks_passed++))
else
    echo -e "${YELLOW}!${NC} abi is not executable, attempting to fix..."
    if chmod +x "${ABI_SCRIPT}" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} abi is now executable (auto-fixed)"
        ((checks_passed++))
    else
        echo -e "${RED}✗${NC} abi is NOT executable and could not be fixed"
        echo -e "  ${YELLOW}Fix:${NC} chmod +x ${ABI_SCRIPT}"
        ((checks_failed++))
    fi
fi

# Check 3: Version works
echo ""
echo -e "${BLUE}Testing basic commands...${NC}"
if [[ ! -x "${ABI_SCRIPT}" ]]; then
    echo -e "${RED}✗${NC} Cannot test (script not executable)"
    ((checks_failed++))
    ((checks_failed++))
elif version=$(timeout 3s "${ABI_SCRIPT}" --version 2>&1 || true); then
    if [[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${GREEN}✓${NC} Version command works: ${version}"
        ((checks_passed++))
        
        if [[ "${version}" == "0.2.0" ]]; then
            echo -e "${GREEN}✓${NC} Running improved version"
            ((checks_passed++))
        else
            echo -e "${YELLOW}!${NC} Version is ${version} (expected 0.2.0)"
        fi
    else
        echo -e "${RED}✗${NC} Version command returned invalid output: ${version}"
        ((checks_failed++))
    fi
else
    echo -e "${RED}✗${NC} Version command failed or timed out"
    ((checks_failed++))
fi

# Check 4: Help works
if [[ ! -x "${ABI_SCRIPT}" ]]; then
    echo -e "${RED}✗${NC} Cannot test (script not executable)"
    ((checks_failed++))
elif timeout 3s "${ABI_SCRIPT}" --help &>/dev/null; then
    echo -e "${GREEN}✓${NC} Help command works"
    ((checks_passed++))
else
    echo -e "${RED}✗${NC} Help command failed or timed out"
    ((checks_failed++))
fi

# Check 5: Dependencies
echo ""
echo -e "${BLUE}Checking dependencies...${NC}"
if command -v brew &>/dev/null; then
    echo -e "${GREEN}✓${NC} Homebrew is installed"
    ((checks_passed++))
else
    echo -e "${RED}✗${NC} Homebrew is NOT installed"
    ((checks_failed++))
fi

if command -v gh &>/dev/null; then
    echo -e "${GREEN}✓${NC} GitHub CLI is installed"
    ((checks_passed++))
    
    if gh auth status &>/dev/null; then
        echo -e "${GREEN}✓${NC} GitHub CLI is authenticated"
        ((checks_passed++))
    else
        echo -e "${YELLOW}!${NC} GitHub CLI is NOT authenticated"
        echo -e "  ${YELLOW}Info:${NC} Run 'gh auth login' to authenticate"
    fi
else
    echo -e "${RED}✗${NC} GitHub CLI is NOT installed"
    ((checks_failed++))
fi

# Summary
echo ""
echo "═══════════════════════════════════════════════════"
echo -e "${BLUE}Summary${NC}"
echo "═══════════════════════════════════════════════════"
echo -e "${GREEN}Passed:${NC} ${checks_passed}"
echo -e "${RED}Failed:${NC} ${checks_failed}"
echo ""

if [[ ${checks_failed} -eq 0 ]]; then
    echo -e "${GREEN}✓ Verification Complete!${NC}"
    echo ""
    echo "Your abi installation is working correctly."
    echo ""
    echo -e "${BLUE}Quick Reference:${NC}"
    echo "  abi --version              # Check version"
    echo "  abi --help                 # See all commands"
    echo "  abi leaves                 # Create Gist from packages"
    echo "  abi install <url>          # Install from Gist"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Please review the issues above."
    echo ""
    exit 1
fi
