# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

RELEASE_COMMIT="2493113afb174b1a0e6f860512922b69c05cee69"

inherit autotools python-single-r1 vala

DESCRIPTION="File syncing and sharing software with file encryption and group sharing"
HOMEPAGE="https://www.seafile.com/ https://github.com/haiwen/seafile/"
SRC_URI="https://github.com/haiwen/${PN}/archive/${RELEASE_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/future[${PYTHON_USEDEP}]
	')
	dev-libs/openssl:=
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/jansson:=
	dev-libs/libevent:=
	net-libs/libsearpc[${PYTHON_SINGLE_USEDEP}]
	net-misc/curl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/${PN}-${RELEASE_COMMIT}"

src_prepare() {
	default
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die
	eautoreconf
	vala_src_prepare
}

src_install() {
	default
	# Remove unnecessary .la files
	find "${ED}" -name '*.la' -o -name '*.a' -delete || die
	python_fix_shebang "${ED}"/usr/bin
}
