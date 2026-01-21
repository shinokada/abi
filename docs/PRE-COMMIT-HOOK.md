# Pre-Commit Hook for ABI

This pre-commit hook helps maintain code quality by running automated checks before each commit.

## What It Does

The hook runs two checks automatically:

### 1. ShellCheck Validation ✓
- Checks all staged bash scripts for common issues
- Uses [ShellCheck](https://www.shellcheck.net/) static analysis
- Catches bugs, style issues, and potential problems
- Only runs on files you're committing

### 2. Test Suite (Optional) ✓
- Runs `tests/test-abi.sh` if the abi script was modified
- Ensures your changes don't break core functionality
- Skips tests if abi wasn't changed
- Can be disabled (see Configuration)

## Installation

### Quick Install

```bash
# From the abi project root
cp pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

### Verify Installation

```bash
# Check if hook is installed
ls -la .git/hooks/pre-commit

# Should show: -rwxr-xr-x ... .git/hooks/pre-commit
```

## Requirements

### Required
- **Git** - Obviously needed for commits
- **Bash** - Already available on macOS/Linux

### Optional
- **ShellCheck** - Highly recommended for code quality
  ```bash
  # Install on macOS
  brew install shellcheck
  
  # Install on Linux
  apt-get install shellcheck  # Ubuntu/Debian
  yum install shellcheck      # CentOS/RHEL
  ```

### For Tests
- **tests/test-abi.sh** - Must exist and be executable
- **brew** and **gh** - For abi functionality

## Usage

Once installed, the hook runs automatically when you commit:

```bash
# Make changes to abi
vim abi

# Stage your changes
git add abi

# Commit (hook runs automatically)
git commit -m "Update abi script"
```

### What You'll See

```text
Running pre-commit checks...

[1/2] Checking bash scripts with shellcheck...
Checking files:
  • abi

✓ abi passed
✓ All shellcheck validations passed

[2/2] Running test suite...
  abi script was modified, running tests...

╔═══════════════════════════════════════════════════╗
║         ABI Script Test Suite                     ║
╚═══════════════════════════════════════════════════╝

...

✓ All tests passed

╔═══════════════════════════════════════════════════╗
║  ✓ All pre-commit checks passed!                 ║
╚═══════════════════════════════════════════════════╝

[main abc1234] Update abi script
```

## Configuration

### Disable Tests

Edit `.git/hooks/pre-commit` and change:

```bash
# At the top of the file
RUN_TESTS=false  # Changed from true
```

Tests will be skipped but shellcheck still runs.

### Disable Hook Entirely

```bash
# Temporarily disable (one commit)
git commit --no-verify -m "Quick fix"

# Permanently disable
rm .git/hooks/pre-commit
```

## Behavior

### Files Checked
The hook checks these file types:
- `*.sh` - Shell scripts
- `*.bash` - Bash scripts
- `abi` - Main abi script
- `abi-improved` - Improved version (if exists)

### When Tests Run
Tests only run when:
- ✅ `RUN_TESTS=true` (default)
- ✅ `tests/test-abi.sh` exists and is executable
- ✅ You modified `abi` or `abi-improved`

Tests are skipped when:
- ⊘ You only changed documentation
- ⊘ You only changed test files
- ⊘ You only changed other scripts

### On Failure

If checks fail:
```text
✗ Commit rejected: shellcheck found issues
Fix the issues above and try again
```

The commit is **blocked** until you fix the issues.

To commit anyway:
```bash
git commit --no-verify -m "Force commit"
```

## Examples

### Example 1: Clean Commit
```bash
$ vim abi  # Make changes
$ git add abi
$ git commit -m "Add new feature"

Running pre-commit checks...
[1/2] Checking bash scripts with shellcheck...
✓ abi passed
✓ All shellcheck validations passed

[2/2] Running test suite...
✓ All tests passed

✓ All pre-commit checks passed!
```

### Example 2: ShellCheck Finds Issue
```bash
$ vim abi  # Introduce a bug
$ git add abi
$ git commit -m "Update script"

Running pre-commit checks...
[1/2] Checking bash scripts with shellcheck...

In abi line 42:
if [ $VAR = "test" ]; then
     ^-- SC2086: Double quote to prevent globbing

✗ shellcheck failed: abi
✗ Commit rejected: shellcheck found issues
```

Fix the issue and try again.

### Example 3: Test Failure
```bash
$ vim abi  # Break something
$ git add abi
$ git commit -m "Update"

Running pre-commit checks...
[1/2] Checking bash scripts with shellcheck...
✓ All shellcheck validations passed

[2/2] Running test suite...
✗ Testing --version flag
✗ Version flag returns invalid format

✗ Commit rejected: tests failed
```

### Example 4: Skip Checks
```bash
# One-time skip
git commit --no-verify -m "Quick fix"

# Or disable tests in hook
vim .git/hooks/pre-commit
# Set: RUN_TESTS=false
```

## Troubleshooting

### Hook Not Running

**Check installation:**
```bash
ls -la .git/hooks/pre-commit
# Should be executable: -rwxr-xr-x
```

**Fix:**
```bash
cp pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

### ShellCheck Not Found

**Install ShellCheck:**
```bash
# macOS
brew install shellcheck

# Linux
apt-get install shellcheck  # Ubuntu/Debian
```

**Or skip ShellCheck:**
The hook continues without it, just shows a warning.

### Tests Not Running

**Check test file:**
```bash
ls -la tests/test-abi.sh
# Should be executable

# Fix:
chmod +x tests/test-abi.sh
```

**Or disable tests:**
Edit `.git/hooks/pre-commit`:
```bash
RUN_TESTS=false
```

### Hook Too Slow

**Disable tests:**
```bash
vim .git/hooks/pre-commit
# Set: RUN_TESTS=false
```

ShellCheck is very fast. Tests add 2-3 seconds.

### False Positives

**Skip specific checks:**
```bash
# Skip hook for one commit
git commit --no-verify -m "Message"
```

**Disable permanently:**
```bash
rm .git/hooks/pre-commit
```

## Benefits

### Why Use This Hook?

1. **Catch Bugs Early** ✓
   - Find issues before they reach the repository
   - Save time debugging later

2. **Maintain Quality** ✓
   - Consistent code style
   - Following bash best practices

3. **Prevent Breakage** ✓
   - Tests catch regressions
   - Confidence in changes

4. **Learn Best Practices** ✓
   - ShellCheck explains issues
   - Improve your bash skills

### What It Prevents

- ❌ Unquoted variables
- ❌ Missing error handling
- ❌ Broken version checks
- ❌ Syntax errors
- ❌ Logic bugs
- ❌ Portability issues

## Customization

### Add More Checks

Edit `.git/hooks/pre-commit`:

```bash
# Add after test suite section
echo -e "${BLUE}[3/3] Custom checks...${NC}"

# Example: Check for TODO comments
if git diff --cached | grep -i "TODO"; then
    echo -e "${YELLOW}⚠ Found TODO comments${NC}"
fi
```

### Change Test Command

```bash
# Instead of tests/test-abi.sh
if tests/verify.sh; then
    # Runs verify.sh instead
fi
```

### Skip Certain Files

```bash
# Filter out specific files
FILES=$(git diff --cached --name-only --diff-filter=ACM | \
    grep -E '\.(sh|bash)$|^abi$' | \
    grep -v 'experimental' || true)
```

## Uninstallation

### Temporary Disable
```bash
# Move hook out of the way
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled
```

### Permanent Removal
```bash
rm .git/hooks/pre-commit
```

## Best Practices

### Do
- ✓ Keep hook fast (< 5 seconds)
- ✓ Make checks relevant to changed files
- ✓ Provide clear error messages
- ✓ Allow bypassing with `--no-verify`
- ✓ Test hook itself periodically

### Don't
- ✗ Make hook too strict (blocks work)
- ✗ Run long-running tests (> 10 seconds)
- ✗ Check files not being committed
- ✗ Require external services
- ✗ Break existing workflows

## FAQ

**Q: Can I skip the hook temporarily?**  
A: Yes: `git commit --no-verify -m "Message"`

**Q: Does this work on Windows?**  
A: Yes, if you have Git Bash or WSL installed

**Q: What if ShellCheck is too strict?**  
A: You can disable specific warnings in code:
```bash
# shellcheck disable=SC2086
variable=$other_variable
```

**Q: Will this slow down my commits?**  
A: Slightly. ShellCheck is fast (~1 second). Tests add 2-3 seconds only when abi changes.

**Q: Can I use this with other projects?**  
A: Yes! Copy and modify for your needs.

**Q: What if tests fail but I need to commit?**  
A: Fix the tests, or use `--no-verify` (not recommended)

## Related Files

- `pre-commit-hook` - The hook file (project root)
- `.git/hooks/pre-commit` - Installed hook location
- `tests/test-abi.sh` - Test suite
- `tests/verify.sh` - Quick verification

## Support

### Getting Help

1. **Check hook status:**
   ```bash
   bash -x .git/hooks/pre-commit
   ```

2. **Test manually:**
   ```bash
   shellcheck abi
   tests/test-abi.sh
   ```

3. **View hook code:**
   ```bash
   cat .git/hooks/pre-commit
   ```

---

**Remember:** The pre-commit hook is a tool to help you, not hinder you. Configure it to match your workflow!
