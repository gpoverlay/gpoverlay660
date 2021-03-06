# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake

inherit cmake-multilib llvm

DESCRIPTION="OpenCL-oriented thin wrapper library around clang"
HOMEPAGE="https://github.com/intel/opencl-clang"
SRC_URI="https://github.com/intel/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="UoI-NCSA"
SLOT="13"
KEYWORDS="~amd64"

DEPEND="
	>=dev-util/spirv-llvm-translator-13.0.0:13=[${MULTILIB_USEDEP}]
	>=sys-devel/clang-13.0.0:13=[static-analyzer,${MULTILIB_USEDEP}]
	sys-devel/llvm:13=[${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

LLVM_MAX_SLOT=13

PATCHES=(
	"${FILESDIR}"/${PN}-8.0.0-clang_library_dir.patch
	"${FILESDIR}"/${PN}-10.0.0.1_find-llvm-tblgen.patch
	"${FILESDIR}"/${PN}-13.0.0_version.patch
)

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="$(get_llvm_prefix ${LLVM_MAX_SLOT})"
		-DCLANG_LIBRARY_DIRS="${EPREFIX}"/usr/lib/clang
	)
	cmake_src_configure
}
