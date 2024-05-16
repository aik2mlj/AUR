# Submitter: AtticFinder65536 <atticfinder -AT- rocklabs -DOT- xyz>
# Maintainer: aik2 <aik2mlj -AT- gmail -DOT- com>

pkgname=('otf-nasin-nanpa')
pkgver=4.0.0
pkgrel=1
pkgdesc="A font for the sitelen pona writing system with UCSUR and ligature support"
url="https://github.com/ETBCOR/nasin-nanpa"
license=('MIT')
source=("$url/releases/download/n${pkgver}/nasin-nanpa-${pkgver}.otf"
	"$url/releases/download/n${pkgver}/nasin-nanpa-${pkgver}-UCSUR.otf"
	"$url/releases/download/n${pkgver}/nasin-nanpa-${pkgver}-Helvetica.otf"
	"$url/raw/n${pkgver}/LICENSE")
sha256sums=('510b2af6a63e467b17b882a304d406850bdd2bb7907c72c9721cd9d49c43304a'
	'1187cda3135a41ba6a8c7ed67cb3dc46427804d88fe0affb0f6433472f8e9955'
	'e25604596a5b5c2c42c26573d072886bc360f365a6491c4e75087a20e5417a27'
	'2bb13a795d1d7f6df0288e228f29e4250e6a0e9b11f90044a737cc024002d6ab')
arch=('any')

package() {
	# Install license
	install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}"

	# Install font
	install -Dm644 -T nasin-nanpa-${pkgver}.otf "${pkgdir}/usr/share/fonts/OTF/nasin-nanpa.otf"
	install -Dm644 -T nasin-nanpa-${pkgver}-UCSUR.otf "${pkgdir}/usr/share/fonts/OTF/nasin-nanpa-UCSUR.otf"
	install -Dm644 -T nasin-nanpa-${pkgver}-Helvetica.otf "${pkgdir}/usr/share/fonts/OTF/nasin-nanpa-Helvetica.otf"
}
