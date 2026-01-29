# AUR Packages

My collection of [Arch User Repository (AUR)](https://aur.archlinux.org/) packages with automated version tracking and updates.

## Packages

| Package                                                                                 | Description                               | Type   |
| --------------------------------------------------------------------------------------- | ----------------------------------------- | ------ |
| [basalt-bin](https://aur.archlinux.org/packages/basalt-bin)                             | TUI for Obsidian vaults                   | Binary |
| [canvas-downloader](https://aur.archlinux.org/packages/canvas-downloader)               | Download Canvas LMS course materials      | Source |
| [canvas-downloader-bin](https://aur.archlinux.org/packages/canvas-downloader-bin)       | Download Canvas LMS course materials      | Binary |
| [chuck-git](https://aur.archlinux.org/packages/chuck-git)                               | Strongly-timed audio programming language | Git    |
| [chugl-git](https://aur.archlinux.org/packages/chugl-git)                               | ChucK graphics library                    | Git    |
| [mini-audicle](https://aur.archlinux.org/packages/mini-audicle)                         | IDE for ChucK                             | Source |
| [otf-librebaskerville-git](https://aur.archlinux.org/packages/otf-librebaskerville-git) | Libre Baskerville font                    | Git    |
| [otf-nasin-nanpa](https://aur.archlinux.org/packages/otf-nasin-nanpa)                   | Sitelen pona (toki pona) font             | Source |
| [plugdata-bin](https://aur.archlinux.org/packages/plugdata-bin)                         | Pure Data as a plugin                     | Binary |
| [plugdata-git](https://aur.archlinux.org/packages/plugdata-git)                         | Pure Data as a plugin                     | Git    |
| [rave-vst](https://aur.archlinux.org/packages/rave-vst)                                 | Neural audio synthesis VST plugin         | Manual |
| [sparta-plugins-bin](https://aur.archlinux.org/packages/sparta-plugins-bin)             | Spatial audio VST/LV2 plugins             | Binary |

## Repository Structure

```
.
├── .github/workflows/     # GitHub Actions for automated updates
├── scripts/               # Helper scripts for local use
├── nvchecker.toml         # Version checking configuration
├── old_ver.json           # Current version tracking
├── <package>/             # Individual package directories
│   ├── PKGBUILD
│   └── .SRCINFO
└── README.md
```

## Automated Updates

A GitHub Actions workflow runs daily to check for new upstream releases using [nvchecker](https://github.com/lilydjwg/nvchecker). When updates are detected, it automatically:

1. Updates `pkgver` in PKGBUILD
2. Resets `pkgrel` to 1
3. Updates checksums with `updpkgsums`
4. Regenerates `.SRCINFO`
5. Pushes to AUR via `git subtree push`
6. Commits changes back to this repository

**Note:** `-git` packages are excluded from automatic updates as they use `pkgver()` functions. Packages marked as "Manual" require manual source download due to license restrictions.

### Manual Workflow Trigger

You can manually trigger the workflow from the [Actions tab](../../actions) with options:

- **Dry run**: Check for updates without making changes
- **Specific package**: Update only a single package

## Manual Package Maintenance

This repository uses [aurpublish](https://github.com/eli-schwartz/aurpublish) with git subtrees to manage packages.

### Prerequisites

```bash
# Install aurpublish
paru -S aurpublish

# Set up git hooks (once per clone)
aurpublish setup
```

### Edit and Publish a Package

```bash
# 1. Edit the PKGBUILD
nvim plugdata-bin/PKGBUILD

# 2. Update checksums
cd plugdata-bin && updpkgsums && cd ..

# 3. Regenerate .SRCINFO (automatic with aurpublish hooks, but can do manually)
cd plugdata-bin && makepkg --printsrcinfo > .SRCINFO && cd ..

# 4. Commit changes
git add plugdata-bin/
git commit -m "plugdata-bin: fix dependency issue"

# 5. Push to AUR
aurpublish plugdata-bin

# 6. Push to GitHub
git push origin main
```

### Pull Changes from AUR

If someone else contributes to your AUR package:

```bash
aurpublish -p plugdata-bin
```

### Add a New Package

```bash
# Import existing AUR package
aurpublish -p new-package-name

# Or create a new directory and add to AUR manually
mkdir new-package
# ... create PKGBUILD and .SRCINFO ...
git add new-package/
git commit -m "new-package: initial commit"
aurpublish new-package
```

## Local Version Checking

```bash
# Install nvchecker
uv tool install nvchecker

# Check for updates
nvchecker -c nvchecker.toml

# Compare versions
nvcmp -c nvchecker.toml
```

## GitHub Secrets Required

For the automated workflow to function, configure these repository secrets:

| Secret                | Description                         |
| --------------------- | ----------------------------------- |
| `AUR_USERNAME`        | Your AUR username                   |
| `AUR_EMAIL`           | Email for git commits               |
| `AUR_SSH_PRIVATE_KEY` | SSH private key registered with AUR |

## License

Individual packages may have different licenses. See each package's PKGBUILD for details.
