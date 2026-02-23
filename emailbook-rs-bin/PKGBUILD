# Maintainer: aik2 <aik2mlj at gmail dot com>

pkgname=emailbook-rs-bin
_name=emailbook
pkgver=0.3.0
pkgrel=1
pkgdesc='A minimalistic address book for e-mails only'
arch=('x86_64')
url='https://github.com/aik2mlj/emailbook-rs'
license=('MIT')
depends=()
optdepends=(
    'bash-completion: bash completions'
    'zsh: zsh completions'
    'fish: fish completions'
)
provides=($_name)
conflicts=($_name)

source=("$url/releases/download/v$pkgver/$_name-v$pkgver-x86_64-unknown-linux-gnu.tar.gz")
sha256sums=('20d43d9185942227858d658362ea929c68ddfe71a680a22a60a4ee2e334b064c')

package() {
    # install binary
    install -Dm755 "$_name" "$pkgdir/usr/bin/$_name"

    # completion directories
    install -d \
        "$pkgdir/usr/share/bash-completion/completions" \
        "$pkgdir/usr/share/zsh/site-functions" \
        "$pkgdir/usr/share/fish/vendor_completions.d"

    # generate completions
    "$pkgdir/usr/bin/$_name" completion bash >"$pkgdir/usr/share/bash-completion/completions/$_name"
    "$pkgdir/usr/bin/$_name" completion zsh >"$pkgdir/usr/share/zsh/site-functions/_$_name"
    "$pkgdir/usr/bin/$_name" completion fish >"$pkgdir/usr/share/fish/vendor_completions.d/$_name.fish"
}
