# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Corsair K65/K70/K95 Driver"
HOMEPAGE="https://github.com/ckb-next/ckb-next"
SRC_URI="https://github.com/ckb-next/ckb-next/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	dev-libs/libdbusmenu-qt
	dev-libs/quazip:0=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-sound/pulseaudio
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libxcb:=
	x11-libs/xcb-util-wm"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

S="${WORKDIR}/${PN}-next-${PV}"

PATCHES=(
	"${FILESDIR}/${P}-libinput-1.2.0.patch"
)

src_configure() {
	local mycmakeargs=(
		-DDISABLE_UPDATER=yes
		-DFORCE_INIT_SYSTEM=$(usex systemd systemd openrc)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc CHANGELOG.md

	newinitd "${FILESDIR}"/ckb.initd ckb-daemon
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "The ckb daemon will have to be started before use:"
		elog
			if use systemd ; then
			elog "# systemctl start ckb-next-daemon"
		else
			elog "# rc-service ckb start"
		fi
	fi
}
