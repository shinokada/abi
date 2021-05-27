# abi

## Overview

abi stands for Automate Brew Install. It will:

- create a Gist of your Homebrew formula or cask
- install Homebrew formula or cask from a Gist

## Installation

### Using Homebrew

```sh
brew tap shinokada/abi && brew install abi
```

### Clone/Download

If you prefer clone/download, you clone/download this repo and make a symlink to your bin directory. Your bin directory needs to be in your PATH variable in your terminal configuration file, such as `~/.zshrc`.

```sh
ln -sf ~/path/to/abi ~/bin/abi
```

## Dependencies

- Homebrew
- Github CLI (gh)

## Usage

```
abi [ -l | --leaves ] [ -c | --cask ] [ -i | --install ] [ -j | --caskinstall ][ -v | --version ] [ -h | --help ]
    -d | --description Gist description. Default: "My brew list" or "My brew cask list"
    -f | --filename    Gist file name. Default: "my-brew-formula" or "my-brew-cask-formula"
    -s | --secret      Gist visibility. Default: -p (Public)
    -v | --version     Script version.
    -l | --leaves      Create a Homebrew formula Gist
    -c | --cask        Create a Homebrew cask formula Gist
    -i | --install     Install Homebrew formula and taps from a Gist
    -j | --installcask Install Homebrew cask formula from a Gist
    -u | --url         Gist URL
    -h | --help        Show help.
```

## Examples

Create a Homebrew formula Gist with the file name and description.

```sh
abi -l
```

Create a Homebrew cask formula Gist with the file name and description.

```sh
abi -c
```

Create a Homebrew Gist with your description and file name.

```sh
abi -l -d "my new brew list" -f hello-brew
abi -c -d "my new brew cask list" -f hello-cask-brew
```

Install Homebrew formula from a Gist.

```sh
abi -i -u <Gist-URL>
```

Install Homebrew cask formula from a Gist.

```sh
abi -j -u <Gist-CASK-URL>
```

Get help.

```sh
abi -h
```

Get the version.

```sh
abi -v
```

## Reference

## Author

Shinichi Okada

## Licence

Please see license.txt.
