#!/bin/bash
# Update a single AUR package to a new version
# Usage: ./scripts/update-package.sh <package-name> <new-version>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <package-name> <new-version>"
    exit 1
fi

PKG_NAME="$1"
NEW_VERSION="$2"
PKG_DIR="$REPO_ROOT/$PKG_NAME"

if [[ ! -d "$PKG_DIR" ]]; then
    echo "Error: Package directory not found: $PKG_DIR"
    exit 1
fi

if [[ ! -f "$PKG_DIR/PKGBUILD" ]]; then
    echo "Error: PKGBUILD not found in $PKG_DIR"
    exit 1
fi

echo "Updating $PKG_NAME to version $NEW_VERSION..."

cd "$PKG_DIR"

# Get current version
OLD_VERSION=$(grep -oP '^pkgver=\K[0-9.]+' PKGBUILD | head -1)
echo "Current version: $OLD_VERSION"
echo "New version: $NEW_VERSION"

if [[ "$OLD_VERSION" == "$NEW_VERSION" ]]; then
    echo "Version is already up to date."
    exit 0
fi

# Special handling for sparta-plugins-bin which has _long_pkgver format
if [[ "$PKG_NAME" == "sparta-plugins-bin" ]]; then
    # Fetch release info to get the full date-prefixed version
    echo "Fetching release info for sparta-plugins-bin..."
    RELEASE_INFO=$(curl -s "https://api.github.com/repos/leomccormack/SPARTA/releases/latest")
    RELEASE_TAG=$(echo "$RELEASE_INFO" | jq -r '.tag_name' | sed 's/^v//')

    # Find the Linux VST3 asset to extract the date prefix
    ASSET_NAME=$(echo "$RELEASE_INFO" | jq -r '.assets[].name' | grep -E '^Linux_SPARTA_VST3_' | head -1)
    if [[ -n "$ASSET_NAME" ]]; then
        # Extract the full version like 2026_01_25_v1.8.2
        LONG_VERSION=$(echo "$ASSET_NAME" | sed -E 's/Linux_SPARTA_VST3_(.*)\.zip/\1/')
        echo "Detected long version: $LONG_VERSION"
        sed -i "s/^_long_pkgver=.*/_long_pkgver=$LONG_VERSION/" PKGBUILD
    fi
else
    # Standard pkgver update
    sed -i "s/^pkgver=.*/pkgver=$NEW_VERSION/" PKGBUILD
fi

# Reset pkgrel to 1
sed -i 's/^pkgrel=.*/pkgrel=1/' PKGBUILD

# Update checksums
echo "Updating checksums..."
if command -v updpkgsums &> /dev/null; then
    updpkgsums
else
    echo "Warning: updpkgsums not found. Please install pacman-contrib."
    echo "Attempting to use makepkg -g..."
    # Get new checksums and update
    NEW_SUMS=$(makepkg -g 2>/dev/null)
    if [[ -n "$NEW_SUMS" ]]; then
        # Remove old sha256sums array and add new one
        sed -i '/^sha256sums=/,/)/d' PKGBUILD
        echo "$NEW_SUMS" >> PKGBUILD
    fi
fi

# Regenerate .SRCINFO
echo "Regenerating .SRCINFO..."
makepkg --printsrcinfo > .SRCINFO

echo "Successfully updated $PKG_NAME to $NEW_VERSION"
echo ""
echo "Changes made:"
echo "  - Updated pkgver to $NEW_VERSION"
echo "  - Reset pkgrel to 1"
echo "  - Updated checksums"
echo "  - Regenerated .SRCINFO"
