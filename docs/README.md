# ABI: Automate Brew Install

```sh
       db        88888888ba  88
      d88b       88      "8b 88
     d8'`8b      88      ,8P 88
    d8'  `8b     88aaaaaa8P' 88
   d8YaaaaY8b    88""""""8b, 88
  d8""""""""8b   88      `8b 88
 d8'        `8b  88      a8P 88
d8'          `8b 88888888P"  88
```

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[Medium article](https://betterprogramming.pub/how-to-automate-homebrew-installs-on-your-new-mac-or-linux-51e06881c5b7)

## Overview

**abi** (Automate Brew Install) is a powerful command-line tool that:

- 📝 Creates GitHub Gists from your Homebrew formula or cask lists
- 🚀 Installs Homebrew packages from Gists with one command
- 🎨 Provides colored, user-friendly output
- 🔍 Offers dry-run mode to preview installations
- 📊 Shows detailed installation summaries
- 🛡️ Includes robust error handling and validation

Perfect for:
- Setting up new machines quickly
- Sharing your Homebrew setup with teams
- Backing up your package lists
- Synchronizing packages across multiple machines

## ✨ New in Version 0.2.0

- 🎨 **Colored output** for better readability
- 🔍 **Dry-run mode** to preview installations
- 📝 **Logging support** to save installation logs
- ✅ **Interactive confirmations** before operations
- 📊 **Installation summaries** with statistics
- 🛡️ **Enhanced error handling** and validation
- ⚡ **ShellCheck compliant** code
- 🧪 **Test suite** included

## Requirements

- **Operating System**: macOS or Linux
- **Homebrew**: [Install Homebrew](https://brew.sh/)
- **GitHub CLI (gh)**: [Install gh](https://cli.github.com/)

## Installation

### Using Homebrew (Recommended)

```bash
brew tap shinokada/abi
brew install abi
```

### Using Awesome Package Manager

After installing [Awesome package manager](https://github.com/shinokada/awesome):

```bash
awesome install shinokada/abi
```

### Manual Installation

Clone this repository and create a symlink:

```bash
git clone https://github.com/shinokada/abi.git
cd abi
chmod +x abi-improved
ln -sf "$(pwd)/abi-improved" ~/bin/abi
```

Make sure `~/bin` is in your `$PATH`.

## Quick Start

### 1. Authenticate GitHub CLI

```bash
gh auth login
```

### 2. Create a Gist from your packages

```bash
# Create a Gist of your Homebrew formulas
abi leaves

# Create a Gist of your Homebrew casks
abi cask
```

### 3. Install packages from a Gist

```bash
# Preview what would be installed (recommended first step)
abi install --dry-run <your-gist-url>

# Install packages
abi install <your-gist-url>
```

## Usage

### Commands

#### Create Gists

```bash
# Create formula list Gist
abi leaves [OPTIONS]

# Create cask list Gist  
abi cask [OPTIONS]
```

#### Install from Gists

```bash
# Install formulas
abi install [OPTIONS] <gist-url>

# Install casks
abi installcask [OPTIONS] <gist-url>
```

### Options

| Option                  | Description                                                             |
| ----------------------- | ----------------------------------------------------------------------- |
| `-d, --desc <text>`     | Set Gist description (default: "My brew list" / "My brew cask list")    |
| `-f, --filename <name>` | Set Gist filename (default: "my-brew-formula" / "my-brew-cask-formula") |
| `-p, --public`          | Make Gist public (default: secret)                                      |
| `--dry-run`             | Preview installation without installing                                 |
| `--log <file>`          | Save log to specified file                                              |
| `-V, --verbose`         | Enable verbose output                                                   |
| `-h, --help`            | Show help message                                                       |
| `-v, --version`         | Show version                                                            |

## Examples

### Creating Gists

**Create a formula Gist with default settings:**
```bash
abi leaves
```

**Create a cask Gist with custom description and filename:**
```bash
abi cask -d "My Essential Apps" -f "essential-casks"
```

**Create a public Gist:**
```bash
abi leaves -p
```

**Create with all custom options:**
```bash
abi leaves -d "Development Tools" -f "dev-tools" -p
```

### Installing from Gists

**Preview before installing (recommended):**
```bash
abi install --dry-run https://gist.github.com/username/abc123
```

**Install with logging:**
```bash
abi install --log install.log https://gist.github.com/username/abc123
```

**Install casks:**
```bash
abi installcask https://gist.github.com/username/def456
```

**Install with verbose output:**
```bash
abi install --verbose https://gist.github.com/username/abc123
```

## Features in Detail

### 🎨 Colored Output

ABI uses colors to make output more readable:
- 🔵 **Blue**: Informational messages
- 🟢 **Green**: Success messages  
- 🟡 **Yellow**: Warnings
- 🔴 **Red**: Errors

Colors are automatically removed from log files.

### 🔍 Dry-Run Mode

Test installations safely without making changes:

```bash
abi install --dry-run https://gist.github.com/username/abc123
```

This shows:
- ✅ Which packages would be installed
- ✅ Which taps would be added
- ✅ Total number of packages
- ❌ No actual changes made

### 📊 Installation Summary

After installation, see a detailed summary:

```
===== Installation Summary =====
  Total packages: 15
  Successfully installed: 13
  Failed: 2

Failed packages:
  - package-that-failed-1
  - package-that-failed-2
```

### ✅ Interactive Confirmations

Before important operations, ABI shows what it will do and asks for confirmation:

```
Gist Configuration:
  Description: My brew list
  Filename: my-brew-formula
  List command: brew leaves
  Visibility: secret

Do you want to create this Gist? (yes/no):
```

### 🛡️ Robust Error Handling

ABI validates:
- ✅ URLs before fetching
- ✅ GitHub CLI authentication
- ✅ Gist content (not empty)
- ✅ Network connectivity
- ✅ Command availability

Clear error messages help you resolve issues quickly.

## Advanced Usage

### Handling Taps

ABI automatically handles Homebrew taps. If your Gist contains:

```
shinokada/abi/abi
shinokada/gitstart/gitstart
jq
wget
```

ABI will:
1. Tap `shinokada/abi`
2. Install `abi` from that tap
3. Tap `shinokada/gitstart`
4. Install `gitstart` from that tap
5. Install `jq` from main repository
6. Install `wget` from main repository

### Logging Installation

Save detailed logs for troubleshooting:

```bash
abi install --log ~/logs/brew-install-$(date +%Y%m%d).log <gist-url>
```

The log file contains:
- All installation steps
- Success/failure status
- Error messages
- Summary statistics

### Creating Backups

Before major changes:

```bash
# Create a backup of current packages
abi leaves -d "Backup $(date +%Y-%m-%d)" -f "backup-$(date +%Y%m%d)"

# Test restore with dry-run
abi install --dry-run <backup-gist-url>
```

## Troubleshooting

### "gh is not authenticated"

```bash
gh auth login
```

Follow the prompts to authenticate.

### "Command 'brew' not found"

Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### "Failed to access Gist URL"

Check that:
1. URL is correct and complete
2. You have internet connectivity
3. Gist exists and is accessible
4. You're authenticated with `gh`

### Installation fails for specific packages

Check the summary for failed packages and install them manually:
```bash
brew install <failed-package>
```

## Development

### Running Tests

```bash
chmod +x test-abi.sh
./test-abi.sh
```

### Installing Pre-commit Hook

```bash
cp pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

This runs shellcheck before each commit.

### Code Quality

The codebase follows:
- ShellCheck recommendations
- Bash best practices
- Consistent formatting (4-space indentation)
- Comprehensive error handling

## Roadmap

Future enhancements planned:

- [ ] Brewfile import/export support
- [ ] Diff command to compare installations
- [ ] Update command for packages
- [ ] Configuration file (~/.abirc)
- [ ] Multiple Gist URL support
- [ ] Interactive package selection (fzf)
- [ ] Rollback mechanism
- [ ] GitHub Actions workflows
- [ ] Package manager integration

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `./test-abi.sh`
5. Submit a pull request

## Changelog

See [IMPROVEMENTS.md](IMPROVEMENTS.md) for detailed changelog.

## Author

**Shinichi Okada**
- GitHub: [@shinokada](https://github.com/shinokada)
- Medium: [Better Programming](https://betterprogramming.pub/how-to-automate-homebrew-installs-on-your-new-mac-or-linux-51e06881c5b7)

## License

MIT License - see [LICENSE](license.txt) for details.

Copyright (c) 2021-2025 Shinichi Okada

## Support

If you find this tool useful, consider:

<a href='https://ko-fi.com/Z8Z2CHALG' target='_blank'><img height='42' style='border:0px;height:42px;' src='https://storage.ko-fi.com/cdn/kofi3.png?v=3' alt='Buy Me a Coffee at ko-fi.com' /></a>

## Acknowledgments

- Homebrew team for the excellent package manager
- GitHub CLI team for the gh tool
- Community contributors and users
