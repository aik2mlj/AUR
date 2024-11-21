# Maintainer: aik2 <aik2mlj@gmail.com>

pkgname=chugl-git
_name=chugl
pkgdesc="ChuGL => ChucK Graphics Library"
pkgver=v0.2.2.r61.g14c228e
pkgrel=1
arch=(x86_64)
url="https://chuck.stanford.edu/chugl/"
license=(MIT)
depends=(chuck)
groups=(pro-audio multimedia)
makedepends=(git)
source=("$_name::git+https://github.com/ccrma/chugl.git")
provides=($_name)
conflicts=($_name)
sha256sums=("SKIP")

pkgver() {
  cd $_name
  # printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
  git describe --long --tags | sed "s/\([^-]*-g\)/r\1/;s/-/./g" | sed "s/chugl.//g"
}

build() {
  cd "$_name/src"
  make linux
}

package() {
  cd $_name
  install -d "$pkgdir/usr/local/lib/chuck/"
  install -Dm755 src/ChuGL.chug "$pkgdir/usr/local/lib/chuck/ChuGL.chug"
}
