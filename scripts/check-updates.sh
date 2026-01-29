#!/bin/bash
# Check for package updates using nvchecker and update if needed
# Usage: ./scripts/check-updates.sh [--dry-run]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "Running in dry-run mode (no changes will be made)"
fi

cd "$REPO_ROOT"

# Check for nvchecker
if ! command -v nvchecker &> /dev/null; then
    echo "Error: nvchecker is not installed."
    echo "Install with: pip install nvchecker"
    exit 1
fi

echo "Checking for updates..."
nvchecker -c nvchecker.toml

# Compare versions and get updates
echo ""
echo "Comparing versions..."
UPDATES=$(nvcmp -c nvchecker.toml 2>/dev/null || true)

if [[ -z "$UPDATES" ]]; then
    echo "All packages are up to date!"
    exit 0
fi

echo "Updates available:"
echo "$UPDATES"
echo ""

# Process each update
UPDATED_PACKAGES=()
while IFS= read -r line; do
    # Parse nvcmp output: "package_name old_version -> new_version"
    if [[ "$line" =~ ^([a-zA-Z0-9_-]+)[[:space:]]+([0-9.]+)[[:space:]]+-\>[[:space:]]+([0-9.]+)$ ]]; then
        PKG_NAME="${BASH_REMATCH[1]}"
        OLD_VER="${BASH_REMATCH[2]}"
        NEW_VER="${BASH_REMATCH[3]}"

        echo "----------------------------------------"
        echo "Updating $PKG_NAME: $OLD_VER -> $NEW_VER"

        if [[ "$DRY_RUN" == "true" ]]; then
            echo "[DRY-RUN] Would update $PKG_NAME to $NEW_VER"
        else
            if "$SCRIPT_DIR/update-package.sh" "$PKG_NAME" "$NEW_VER"; then
                UPDATED_PACKAGES+=("$PKG_NAME")
            else
                echo "Warning: Failed to update $PKG_NAME"
            fi
        fi
    fi
done <<< "$UPDATES"

if [[ "$DRY_RUN" == "false" && ${#UPDATED_PACKAGES[@]} -gt 0 ]]; then
    # Update old_ver.json with new versions
    echo ""
    echo "Updating version tracking file..."
    cp new_ver.json old_ver.json

    echo ""
    echo "Summary: Updated ${#UPDATED_PACKAGES[@]} package(s):"
    printf '  - %s\n' "${UPDATED_PACKAGES[@]}"
fi
