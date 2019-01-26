# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A simple ebook reader originally intended for Elementary OS"
HOMEPAGE="http://babluboy.github.io/bookworm"
SRC_URI="https://github.com/babluboy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""

RDEPEND=">=dev-lang/vala-0.42"

S="${WORKDIR}/bookworm-${PV}"

src_prepare(){
	eapply_user

	vala_src_prepare --vala-api-version 0.42
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
