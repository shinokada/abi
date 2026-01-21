# ABI Tests

Quick and reliable tests for the abi tool.

## Quick Start

```bash
# Make scripts executable
chmod +x test-abi.sh verify.sh

# Run verification (quick health check - 1 second)
./verify.sh

# Run full test suite (comprehensive - 3 seconds)
./test-abi.sh
```

## Scripts

### verify.sh - Quick Health Check ⚡

Fast verification (< 1 second) that checks:
- ✓ abi script exists and is executable
- ✓ Version command works
- ✓ Help command works  
- ✓ Dependencies installed (brew, gh)
- ✓ GitHub CLI authentication status

**When to use:**
- Quick check after installation
- Verify after system updates
- Troubleshooting

```bash
./verify.sh
```

### test-abi.sh - Full Test Suite 🧪

Comprehensive tests (< 3 seconds) that verify:
- ✓ File existence
- ✓ Executable permissions
- ✓ Version flag functionality
- ✓ Help flag functionality
- ✓ Shebang line correctness

**When to use:**
- Before committing changes
- After modifying abi script
- Detailed validation

```bash
./test-abi.sh
```

## What Gets Tested

### ✅ Things These Tests Check

Both scripts test functionality that **works without**:
- ❌ GitHub CLI authentication
- ❌ Internet connection
- ❌ Creating actual Gists
- ❌ Installing packages

They test:
1. **File System** - Files exist, permissions correct
2. **Basic Commands** - `--version` and `--help` work
3. **Output Format** - Version matches semantic versioning
4. **Dependencies** - brew and gh are installed
5. **Script Structure** - Shebang is correct

### ℹ️ Things NOT Tested

These require manual testing:
- Creating Gists (needs `gh auth login`)
- Installing packages (needs internet + Gist URLs)
- Homebrew operations (needs actual packages)

## Expected Output

### verify.sh Success
```
╔═══════════════════════════════════════════════════╗
║     ABI Installation Verification                 ║
╚═══════════════════════════════════════════════════╝

Checking installation...
✓ abi script found
✓ abi is executable

Testing basic commands...
✓ Version command works: 0.2.0
✓ Running improved version
✓ Help command works

Checking dependencies...
✓ Homebrew is installed
✓ GitHub CLI is installed
! GitHub CLI is NOT authenticated
  Info: Run 'gh auth login' to authenticate

═══════════════════════════════════════════════════
Summary
═══════════════════════════════════════════════════
Passed: 7
Failed: 0

✓ Verification Complete!
```

### test-abi.sh Success
```
╔═══════════════════════════════════════════════════╗
║         ABI Script Test Suite                     ║
╚═══════════════════════════════════════════════════╝

Testing: /Users/you/Bash/abi/abi

═══════════════════════════════════════════════════
Test 1: File Existence
═══════════════════════════════════════════════════
✓ abi script exists

═══════════════════════════════════════════════════
Test 2: Executability
═══════════════════════════════════════════════════
✓ Script is executable

═══════════════════════════════════════════════════
Test 3: Version Flag
═══════════════════════════════════════════════════
✓ Version command works: 0.2.0

═══════════════════════════════════════════════════
Test 4: Help Flag
═══════════════════════════════════════════════════
✓ Help command works

═══════════════════════════════════════════════════
Test 5: Shebang Line
═══════════════════════════════════════════════════
✓ Has valid bash shebang: #!/usr/bin/env bash

═══════════════════════════════════════════════════
Test Summary
═══════════════════════════════════════════════════
Tests run: 5
Passed: 5
Failed: 0

✓ All tests passed!

The abi script is working correctly.
```

## Why These Tests Work

### The Problem Before
Old tests would **hang forever** because they:
- Tried to test commands that required GitHub authentication
- Would wait for interactive input
- Had complex setup logic that could fail

### The Solution Now
New tests are:
- ⚡ **Fast** - Complete in 1-3 seconds
- 🎯 **Focused** - Only test what can be tested without external dependencies
- 🔒 **Safe** - Use timeouts to prevent hanging
- 📊 **Clear** - Provide informative output
- ✅ **Reliable** - Work every time

## Troubleshooting

### Script Not Executable
```bash
chmod +x test-abi.sh verify.sh
chmod +x ../abi
```

### Tests Timeout
If tests timeout, your abi script might have issues:
```bash
# Test manually
../abi --version
../abi --help
```

### Dependencies Missing
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install GitHub CLI
brew install gh

# Authenticate (optional, not needed for tests)
gh auth login
```

## Running from Project Root

```bash
# From /Users/you/Bash/abi
tests/verify.sh
tests/test-abi.sh
```

## Cleanup Old Test Files

If you have old broken test files:

```bash
chmod +x cleanup-tests.sh
./cleanup-tests.sh
```

This removes:
- `test-abi-simple.sh` - Replaced by `test-abi.sh`
- `debug-test.sh` - No longer needed

## Integration with Pre-Commit Hook

The pre-commit hook uses `test-abi.sh`:

```bash
# Install hook
cp ../pre-commit-hook ../.git/hooks/pre-commit
chmod +x ../.git/hooks/pre-commit

# Tests run automatically on commit
git commit -m "Update abi"
```

See `../docs/PRE-COMMIT-HOOK.md` for details.

## Files in This Directory

```
tests/
├── test-abi.sh          # Full test suite (5 tests)
├── verify.sh            # Quick verification
├── README.md            # This file
├── EXPLANATION.md       # Why old tests broke
└── cleanup-tests.sh     # Remove old test files
```

## Quick Commands

```bash
# Health check (1 second)
./verify.sh

# Full tests (3 seconds)
./test-abi.sh

# Clean up old files
./cleanup-tests.sh

# Make everything executable
chmod +x *.sh
```

## Do You Need These Tests?

### Keep them if you:
- ✅ Want quick health checks
- ✅ Modify the abi script
- ✅ Like automated validation

### Remove them if you:
- ❌ Never modify abi
- ❌ Prefer manual testing only

To remove:
```bash
cd ..
rm -rf tests/
```

## Questions?

- **Tests hanging?** They shouldn't anymore! If they do, check if abi is executable
- **Want more tests?** These cover core functionality without external dependencies
- **Need help?** Run `../abi --help` or check the docs

---

**These tests are simple, fast, and reliable!** They complete in seconds and never hang. 🎉
