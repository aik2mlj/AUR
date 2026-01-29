# Maintainer: aik2 <aik2mlj@gmail.com>
# Contributor: spider-mario <spidermario@free.fr>
pkgname=mini-audicle
pkgver=1.5.5.7
pkgrel=1
pkgdesc='Integrated Development + Performance Environment for ChucK'
arch=('x86_64')
url="https://github.com/ccrma/miniAudicle"
license=('GPL')
groups=('multimedia' 'pro-audio')
depends=('qt6-base' 'qscintilla-qt6' 'libsndfile'
    # Uncomment one of the following three lines depending on the backend that you
    # want. Also uncomment the corresponding make target in build() below.
    # Default: PulseAudio
    #        'libpulse'
    #        'alsa-lib'
    'jack'
)
makedepends=('git')
optdepends=('chuck: for documentation and command line interface')
source=("git+https://github.com/ccrma/miniAudicle.git#tag=chuck-$pkgver"
    'miniAudicle.desktop')
sha256sums=('2e4da9c4a9beb4d337bc14449012a0496238525ccd21d4485d601671488c7718'
    '3b78ff8420a6ed644a6963591491b2ab20c3f613fb03114a7c9044ded8ebd6f0')

prepare() {
    cd miniAudicle/src
    git submodule update --init --recursive --depth=1
}

build() {
    cd miniAudicle/src
    export QMAKE=qmake6
    export QT_SELECT=qt6
    make linux-jack
    #		linux-pulse
    #		linux-alsa
}

package() {
    install -Dm644 miniAudicle.desktop "$pkgdir"/usr/share/applications/miniAudicle.desktop

    cd miniAudicle/src
    install -Dm755 miniAudicle "$pkgdir"/usr/bin/miniAudicle
    install -Dm644 qt/icon/miniAudicle.png "$pkgdir"/usr/share/pixmaps/miniAudicle.png
}
