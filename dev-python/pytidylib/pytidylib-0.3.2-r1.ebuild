# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Python wrapper for HTML Tidy (tidylib)"
HOMEPAGE="http://countergram.com/open-source/pytidylib https://github.com/countergram/pytidylib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="app-text/htmltidy"
DEPEND=${RDEPEND}

distutils_enable_tests pytest
