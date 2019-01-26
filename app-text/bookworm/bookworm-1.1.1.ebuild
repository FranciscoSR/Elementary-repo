# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.26"
PYTHON_COMPAT=( python2_7 )

inherit gnome2-utils meson vala xdg-utils python-r1 

DESCRIPTION="A simple ebook reader originally intended for Elementary OS"
HOMEPAGE="http://babluboy.github.io/bookworm"
SRC_URI="https://github.com/babluboy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="
	>=dev-lang/vala-0.42
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"


RDEPEND="${DEPEND}
	dev-libs/granite
	app-text/poppler[cairo]
	app-arch/unzip
	app-arch/unrar
	net-libs/webkit-gtk:4/37
	x11-libs/gtk+:3
	dev-db/sqlite:3
	dev-python/html2text[${PYTHON_USEDEP}]
"

S="${WORKDIR}/bookworm-${PV}"

src_prepare(){
	eapply_user
	vala_src_prepare --vala-api-version 0.42
}

src_configure(){

	meson_src_configure
}

pkg_preinst(){
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
