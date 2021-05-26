# trbf

## Overview

trbf stands for Transmit Brew Formula. It will:

- create a Gist of your Homebrew formula or cask
- install Homebrew formula or cask from a Gist

## Installation

### Using Homebrew

```sh
brew tap shinokada/trbf && brew install trbf
```

### Clone/Download

Clone or download this repo and make a symlink to your bin directory.

```sh
ln -sf ~/path/to/trbf ~/bin/trbf
```

## Dependencies

- Homebrew
- Github CLI (gh)

## Usage

```
./trbf [ -l | --leaves ] [ -c | --cask ] [ -i | --install ] [ -j | --caskinstall ][ -v | --version ] [ -h | --help ]
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
trbf -l
```

Create a Homebrew cask formula Gist with the file name and description.

```sh
trbf -c
```

Create a Homebrew Gist with your description and file name.

```sh
trbf -l -d "my new brew list" -f hello-brew
trbf -c -d "my new brew cask list" -f hello-cask-brew
```

Install Homebrew formula from a Gist.

```sh
trbf -i -u <Gist-URL>
```

Install Homebrew cask formula from a Gist.

```sh
trbf -j -u <Gist-CASK-URL>
```

Get help.

```sh
trbf -h
```

Get the version.

```sh
trbf -v
```

## Reference

## Author

Shinichi Okada

## Licence

Please see license.txt.
