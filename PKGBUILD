# Maintainer:  aik2 <aik2mlj at gmail dot com>
# Maintainer:  jingyen <lohjingyen at gmail dot com>

pkgname=canvas-downloader-bin
_name=canvas-downloader
pkgver=0.3.2
pkgrel=1
pkgdesc='Download and organize all your Canvas course materials 📚'
depends=('gcc-libs' 'openssl')
arch=('x86_64')
url='https://github.com/aik2mlj/canvas-downloader'
license=('GPL-3.0-or-later')
provides=($_name)
conflicts=($_name)
source=("$url/releases/download/v$pkgver/$_name-x86_64-unknown-linux-gnu-v$pkgver")
sha256sums=('5f527fdb5da34b5a62979cbdacd250656ae8a368cb0cdc4d49e7f101912142c4')

package() {
    install -Dm755 "$_name-x86_64-unknown-linux-gnu-v$pkgver" "$pkgdir/usr/bin/$_name"
}
