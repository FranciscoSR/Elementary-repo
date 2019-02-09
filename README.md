Another Unofficial Elementary-OS overlay based on the Gnome-next repository to work on open-rc.

**FOR PERSONAL PURPOSE

**To install the Pantheon desktop you need to install the dantrell-gnome-3-28 overlay repository that satisfies the dependencies of the elementarty ebuild to work without systemd.

Versions
--------

 - Pantheon `Juno` ebuilds

Major differences with the main tree
-------------------------

 - To use the latest versions of vala, mask the old vala version to see the limitations. Currently, the only way to use the new vala is to port everything to this overlay.

Pantheon
--------
minimal installation:
 - pantheon-shell (excludes wingpanel-indicators, switchboard-plugs)

full installation:
 - pantheon-meta
 - USE="minimal" excludes elementary-apps (default +minimal)
 - bluetooth the section is not checked
 - switchboard-plug-notifications the plugin is tied to the Ubuntu. ideally, it should be rewritten. It's useless now
 - switchboard-plug-useraccounts a little unfinished. it is tied to the accountsservice with patches from Debian. But these patches are not yet in gentoo.

(Dirli's cooment: below is written by someone else, left it, suddenly someone come in handy)
 - Entries from `/usr/share/gnome/autostart` are loaded.

Here is an example `.xinitrc`:

``` shell
#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#not sure about block below
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/gnome-settings-daemon/gnome-settings-daemon &
/usr/lib/gnome-user-share/gnome-user-share &
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

#sometimes pantheon-session also will work
gsettings-data-convert &
xdg-user-dirs-gtk-update &
xrdb merge ~/.Xresources &&
wingpanel &
plank &
exec gala
e

[Twitter]: http://mxtoolbox.com/Public/images/twitter-icon.png
