# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

FROM_LANG="English"
TO_LANG="Traditional Chinese (BIG5)"
DICT_PREFIX="xdict-ec-"
DICT_SUFFIX="big5"

inherit stardict

HOMEPAGE="http://download.huzheng.org/zh_TW/"

KEYWORDS="~amd64 ~ppc ~riscv ~sparc ~x86"
IUSE=""
