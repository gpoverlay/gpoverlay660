# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit python-single-r1 toolchain-funcs

DESCRIPTION="Command-line ape 2.0 tagger"
HOMEPAGE="http://muth.org/Robert/Apetag/"
SRC_URI="http://muth.org/Robert/Apetag/${PN}.${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~riscv x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN^}

DOCS=( 00readme )

PATCHES=(
	"${FILESDIR}/${P}-py3.patch"
)

src_prepare() {
	default
	sed -i \
		-e 's:CXXDEBUG:LDFLAGS:' \
		Makefile || die
	python_fix_shebang *.py
}

src_compile() {
	tc-export CXX
	emake \
		CXXFLAGS="${CXXFLAGS} -Wall -pedantic" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}

	python_moduleinto /usr/lib/apetag
	python_domodule *.py

	fperms +x /usr/lib/apetag/{rmid3tag,tagdir}.py
	dosym ../lib/apetag/rmid3tag.py /usr/bin/rmid3tag.py
	dosym ../lib/apetag/tagdir.py /usr/bin/tagdir.py

	einstalldocs
}