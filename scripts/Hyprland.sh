#!/bin/sh

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Init keyring
eval "$(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)"

# Export keyring
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# Update DBUS ENVs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Launch desktop portals
~/.config/hypr/scripts/xdg-desktop-portal-hyprland

exec Hyprland
