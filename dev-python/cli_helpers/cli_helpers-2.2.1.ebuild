# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python helpers for common CLI tasks"
HOMEPAGE="https://cli-helpers.rtfd.io/"
SRC_URI="https://github.com/dbcli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/configobj-5.0.5[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.8.0[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
