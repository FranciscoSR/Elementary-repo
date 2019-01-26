# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="Switchboard Online Accounts Plug."
HOMEPAGE="https://github.com/elementary/switchboard-plug-onlineaccounts"
SRC_URI="https://github.com/elementary/switchboard-plug-onlineaccounts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-0.4.1
	dev-libs/libgee:0.8
	dev-libs/libpwquality
	gnome-base/gnome-desktop:3
	pantheon-base/switchboard
	sys-apps/accountsservice
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	
	vala_src_prepare --vala-api-version 0.42
}
