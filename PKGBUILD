# Maintainer:  aik2 <aik2mlj at gmail dot com>

pkgname=canvas-downloader
pkgver=0.4.0
pkgrel=1
pkgdesc='Download and organize all your Canvas course materials 📚'
arch=('x86_64')
url='https://github.com/aik2mlj/canvas-downloader'
license=('GPL-3.0-or-later')

depends=('gcc-libs' 'openssl')
makedepends=('cargo' 'git')
optdepends=(
    'bash-completion: bash completions'
    'zsh: zsh completions'
    'fish: fish completions'
)

source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('7960eb2d023ab7b2513ba2bf1900f8568d022193491beec58ee3612e56f44c02')

build() {
    cd "$srcdir/canvas-downloader-$pkgver"
    export CARGO_HOME="$srcdir/cargo-home"
    export CARGO_TARGET_DIR="$srcdir/target"
    cargo build --release --locked
}

package() {
    cd "$srcdir/canvas-downloader-$pkgver"

    install -Dm755 "$CARGO_TARGET_DIR/release/canvas-downloader" "$pkgdir/usr/bin/canvas-downloader"

    # License (Arch convention)
    install -Dm644 LICENSE* "$pkgdir/usr/share/licenses/$pkgname/LICENSE" 2>/dev/null || true

    # Completions
    install -d \
        "$pkgdir/usr/share/bash-completion/completions" \
        "$pkgdir/usr/share/zsh/site-functions" \
        "$pkgdir/usr/share/fish/vendor_completions.d"

    # generate completions
    "$pkgdir/usr/bin/$pkgname" completions bash >"$pkgdir/usr/share/bash-completion/completions/$pkgname"
    "$pkgdir/usr/bin/$pkgname" completions zsh >"$pkgdir/usr/share/zsh/site-functions/_$pkgname"
    "$pkgdir/usr/bin/$pkgname" completions fish >"$pkgdir/usr/share/fish/vendor_completions.d/$pkgname.fish"
}
