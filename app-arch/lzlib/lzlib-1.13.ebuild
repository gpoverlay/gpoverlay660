# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Library for lzip compression"
HOMEPAGE="https://www.nongnu.org/lzip/lzlib.html"
SRC_URI="https://download.savannah.gnu.org/releases/lzip/${PN}/${P}.tar.gz"

LICENSE="libstdc++" # fancy form of GPL-2+ with library exception
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

src_configure() {
	local myconf=(
		--enable-shared
		--disable-static
		--disable-ldconfig
		--prefix="${EPREFIX}"/usr
		--libdir='$(prefix)'/$(get_libdir)
		CC="$(tc-getCC)"
		CFLAGS="${CFLAGS}"
		CPPFLAGS="${CPPFLAGS}"
		LDFLAGS="${LDFLAGS}"
	)

	# not autotools-based
	./configure "${myconf[@]}" || die
}
