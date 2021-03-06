# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_SINGLE_IMPL=1
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="A framework for managing and maintaining multi-language Git pre-commit hooks"
HOMEPAGE="https://pre-commit.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"

# TODO: figure out why these tests - all of which invoke git - fail:
#  - tests/main_test.py::test_all_cmds[autoupdate,hook-impl,install,install-hooks,migrate-config,run,uninstall],
#    tests/main_test.py::test_try_repo:
#     Calling "git rev-parse" fails with "fatal: not a git repository (or any of the parent directories): .git".
#     NOT a sandbox issue it seems, as disabling it does not help.
#  - tests/commands/install_uninstall_test.py::test_environment_not_sourced:
#      Unexpected error "/usr/bin/env: 'python3.8': No such file or directory" - but only if pre-commit
#      has previously been installed.
#  - tests/commands/install_uninstall_test.py::test_installed_from_venv:
#     the function invoking "git commit" returns 1 instead of 0, no details.
RESTRICT="test"

RDEPEND="dev-vcs/git
	$(python_gen_cond_dep '
		>=dev-python/cfgv-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/identify-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/nodeenv-0.11.1[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
		>=dev-python/virtualenv-20.0.8[${PYTHON_USEDEP}]
	')"
BDEPEND="test? (
	$(python_gen_cond_dep '
		dev-python/pytest-env[${PYTHON_USEDEP}]
		dev-python/re-assert[${PYTHON_USEDEP}]
	')
)"

DOCS=( CHANGELOG.md CONTRIBUTING.md README.md )

distutils_enable_tests --install pytest

src_prepare() {
	default

	# These tests require a boatload of dependencies (e.g. Conda, Go, R and more) in order to run
	# and while some of them do include "skip if not found" logic, most of them do not.
	rm -rf tests/languages tests/repository_test.py
}
