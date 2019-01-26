# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.42

inherit gnome2-utils meson vala 

DESCRIPTION="Edit application menu"
HOMEPAGE="https://github.com/donadigo/appeditor"
SRC_URI="https://github.com/donadigo/appeditor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="
	>=pantheon-base/wingpanel-2.0
	virtual/opengl
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/appeditor-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare --vala-api-version 0.42

}


pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
