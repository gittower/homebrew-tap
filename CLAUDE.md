# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Homebrew tap repository for distributing the `git-flow-next` tool. It contains a single Homebrew formula that manages the installation of git-flow-next binaries for different platforms (macOS Intel/ARM, Linux Intel/ARM).

## Key Commands

### Testing the Formula
```bash
brew test gittower/tap/git-flow-next
```

### Automated Formula Updates
```bash
./update_formula.rb
```

This script automatically:
- Fetches the latest release from GitHub
- Downloads checksums for all platforms
- Updates the formula with new version and checksums
- Commits changes with message "Update to {version}"

### Manual Formula Updates

If you need to manually update the formula:

1. Edit `Formula/git-flow-next.rb.template` with any structural changes
2. Update the version string in the template
3. Update all URL paths to point to the new release version
4. Update all SHA256 checksums for each platform's tarball
5. Run the update script to generate the final formula

The formula handles four platform variants:
- macOS Intel (darwin-amd64)
- macOS ARM (darwin-arm64)  
- Linux Intel (linux-amd64)
- Linux ARM (linux-arm64)

Each platform section requires:
- URL to the release tarball
- SHA256 checksum of the tarball
- Binary installation mapping (extracts versioned binary, installs as `git-flow`)

## Architecture

The repository structure is minimal:
- `Formula/git-flow-next.rb` - The Homebrew formula that defines how to install git-flow-next
- The formula uses conditional logic to select the appropriate binary based on OS and CPU architecture
- Binary files are renamed during installation from versioned names to the standard `git-flow` command