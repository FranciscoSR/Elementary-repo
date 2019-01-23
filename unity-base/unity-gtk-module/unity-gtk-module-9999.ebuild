# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils python-r1 versionator bzr

DESCRIPTION="GTK+ module for exporting old-style menus as GMenuModels"
HOMEPAGE="https://launchpad.net/unity-gtk-module"
EBZR_REPO_URI="lp:unity-gtk-module"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/libdbusmenu:=[gtk3]"
DEPEND="${RDEPEND}
	>=dev-libs/glib-2.38
	x11-libs/libX11
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	!x11-misc/appmenu-gtk"

pkg_setup() {
	python_export_best
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-gsettings.patch"
	eautoreconf
}

src_configure() {
	# Build GTK2 support #
	[[ -d build-gtk2 ]] || mkdir build-gtk2
	pushd build-gtk2
		../configure --prefix=/usr \
			--sysconfdir=/etc \
			--disable-static \
			--with-gtk=2 || die
	popd

	# Build GTK3 support #
	[[ -d build-gtk3 ]] || mkdir build-gtk3
	pushd build-gtk3
		../configure --prefix=/usr \
		--sysconfdir=/etc \
		--disable-static || die
	popd
}

src_compile() {
	# Build GTK2 support #
	pushd build-gtk2
		emake || die
	popd

	# Build GTK3 support #
	pushd build-gtk3
		emake || die
	popd
}

src_install() {
	# Install GTK2 support #
	pushd build-gtk2
		emake DESTDIR="${D}" install || die
	popd

	# Install GTK3 support #
	pushd build-gtk3
		emake DESTDIR="${D}" install || die
	popd

	rm -rf "${D}etc" &> /dev/null
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}/81unity-gtk-module"

	# Remove upstart jobs as we use xsession based scripts in /etc/X11/xinit/xinitrc.d/ #
	rm -rf "${ED}usr/share/upstart"

	prune_libtool_files --modules
}
