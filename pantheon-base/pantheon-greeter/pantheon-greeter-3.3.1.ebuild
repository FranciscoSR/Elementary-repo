# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.42

inherit gnome2-utils vala cmake-utils

DESCRIPTION="Pantheon Login Screen for LightDM"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="
	media-fonts/raleway
	media-libs/clutter-gtk:1.0
	>=pantheon-base/wingpanel-2.0
	virtual/opengl
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.1[vala]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/greeter-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare --vala-api-version 0.42

}


pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
