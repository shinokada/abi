# Abi

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

## Overview

abi stands for Automate Brew Install. It will:

- create a Gist of your Homebrew formula or cask
- install Homebrew formula or cask from a Gist

## Requirement

UNIX-lie (Tested on Ubuntu and MacOS.)

## Installation

### Using Homebrew

```sh
brew tap shinokada/abi && brew install abi
```

### Using Awesome package manager

After installing [Awesome package manager](https://github.com/shinokada/awesome)

```sh
awesome -i shinokada/abi
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

```sh
abi leaves [ -d <description> ][ -f <file name> ][-s]
abi cask [ -d <description> ][ -f <file name> ][-s]
abi install <Gist-url>
abi installcask <Gist-url>
```

## Options

| Options         | Description                                                          |
| --------------- | -------------------------------------------------------------------- |
| -d , --desc     | Gist description. Default "My brew list" and "My brew cask list"     |
| -f , --filename | Gist file name. Default "my-brew-formula" and "my-brew-cask-formula" |
| -s , --secret   | Gist visibility. Default -p (Public)                                 |
| -h , --help     | Show help.                                                           |
| -v , --version  | Script version.                                                      |

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

MIT License

Copyright (c) 2021 Shinichi Okada

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.