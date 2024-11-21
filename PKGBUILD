# Maintainer: aik2 <aik2mlj@gmail.com>

pkgname=chuck-git
_name=chuck
pkgdesc='Concurrent, on-the-fly audio programming language'
pkgver=1.5.4.1.r24.g01efb5a1
pkgrel=1
arch=(x86_64)
url='https://chuck.stanford.edu/'
license=('GPL-2.0-or-later OR MIT')
depends=(jack libsndfile)
groups=(pro-audio)
makedepends=(git)
source=("$_name::git+https://github.com/ccrma/chuck.git")
provides=($_name)
conflicts=($_name)
sha256sums=('SKIP')

pkgver() {
  cd $_name
  # printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
  git describe --long --tags | sed "s/\([^-]*-g\)/r\1/;s/-/./g" | sed "s/chuck.//g"
}

build() {
  cd "$_name/src"
  make linux-jack
}

package() {
  cd $_name
  install -d "$pkgdir/usr/share/doc/$_name"
  cp -r examples "$pkgdir/usr/share/doc/$_name"
  install -Dm755 src/$_name "$pkgdir/usr/bin/$_name"
}
