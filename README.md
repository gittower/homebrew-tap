# homebrew-tap

This is the official Homebrew tap for installing [`git-flow-next`](https://github.com/gittower/git-flow-next) — a modern, Go-based reimplementation of the Git Flow branching model.

## What is git-flow-next?

`git-flow-next` is a CLI tool that manages Git workflows using the branching model popularized by the original [git-flow](https://github.com/nvie/gitflow) and [git-flow-avh](https://github.com/petervanderdoes/gitflow-avh). This project reimplements the model in Go, providing faster performance, better integration, and extensibility.

## Installation

### Install git-flow-next

```bash
brew install gittower/tap/git-flow-next
```
### Upgrading

```bash
brew update
brew upgrade git-flow-next
```

### Uninstallation

```bash
brew uninstall git-flow-next
```

### Development

To update the formula after a new git-flow-next release:

1. Update the version number in `Formula/git-flow-next.rb`
2. Replace the URLs with the new release asset URLs
3. Update all corresponding SHA256 checksums
4. Commit and push