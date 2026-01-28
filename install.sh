#!/usr/bin/env bash
set -e

# ===============================
# NON-ROOT CHECK
# ===============================
if [[ "$EUID" -eq 0 ]]; then
  echo "❌ Do NOT run this script as root."
  echo "➡️ Run it as a normal user. sudo will be requested when needed."
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "❌ sudo is not installed."
  exit 1
fi

# ===============================
# FEDORA CHECK
# ===============================
if [[ ! -f /etc/os-release ]]; then
  echo "❌ Unable to detect operating system."
  exit 1
fi

. /etc/os-release

if [[ "$ID" != "fedora" ]]; then
  echo "❌ This script is intended for Fedora only."
  exit 1
fi

FEDORA_VERSION="${VERSION_ID%%.*}"

if (( FEDORA_VERSION < 39 )); then
  echo "❌ Fedora $FEDORA_VERSION is not supported (minimum Fedora 39)."
  exit 1
fi

echo "✅ Fedora $VERSION_ID detected"

# ===============================
# REQUEST SUDO
# ===============================
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ===============================
# HELPERS
# ===============================
is_installed() {
  rpm -q "$1" &>/dev/null
}

install_packages() {
  local to_install=()

  for pkg in "$@"; do
    if is_installed "$pkg"; then
      echo "✔ $pkg already installed — skipping"
    else
      to_install+=("$pkg")
    fi
  done

  if (( ${#to_install[@]} > 0 )); then
    sudo dnf install -y "${to_install[@]}"
  fi
}

# ===============================
# BASE PACKAGES
# ===============================
echo "📦 Installing required packages..."

# Note: 'niri' is available in Fedora repo (updates-testing for some versions) or COPR.
# We will enable COPR for niri just in case, or assume it's in the repo.
# Fedora 41+ has niri in repos. For now we will try installing it directly.

install_packages \
  niri \
  rofi \
  waybar \
  power-profiles-daemon \
  grim \
  slurp \
  wl-clipboard \
  mako \
  python3-pydbus \
  NetworkManager \
  network-manager-applet \
  bluez \
  bluez-tools \
  blueman \
  nwg-look \
  adw-gtk3-theme \
  waypaper \
  swww \
  swaylock \
  alacritty \
  fastfetch \
  dnf-plugins-core

# ===============================
# FLATPAK GTK THEME
# ===============================
echo "🎨 Applying Flatpak GTK theme overrides..."
if command -v flatpak >/dev/null 2>&1; then
  sudo flatpak override --filesystem=xdg-data/themes
  sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3-dark || true
else
  echo "⚠️ Flatpak not found, skipping flatpak overrides."
fi

# ===============================
# COPY CONFIG FILES
# ===============================
echo "📁 Copying config files..."
mkdir -p ~/.config
cp -rn .config/* ~/.config/ || true

# ===============================
# FONTS
# ===============================
echo "🔤 Installing fonts..."
if [ -d ".local/share/fonts" ]; then
  mkdir -p ~/.local/share/fonts
  cp -rn .local/share/fonts/* ~/.local/share/fonts/ || true
  fc-cache -fv
else
  echo "⚠️ .local/share/fonts directory not found, skipping fonts."
fi

# ===============================
# ICONS
# ===============================
echo "🖼 Installing icons..."
if [ -d ".icons" ]; then
  mkdir -p ~/.local/share/icons
  cp -rn .local/share/icons/* ~/.local/share/icons/ || true
else
  echo "⚠️ .icons directory not found, skipping icons."
fi

# ===============================
# WAYBAR MAKO SCRIPT
# ===============================
echo "🔔 Installing Waybar mako notification script..."
mkdir -p ~/.local/bin

if [[ ! -f ~/.local/bin/waybar-mako-notif.py ]]; then
  if [[ -f .local/bin/waybar-mako-notif.py ]]; then
    cp .local/bin/waybar-mako-notif.py ~/.local/bin/
    chmod +x ~/.local/bin/waybar-mako-notif.py
  else
     echo "⚠️ Source waybar-mako-notif.py not found, skipping."
  fi
else
  echo "✔ waybar-mako-notif.py already exists — skipping"
fi

# ===============================
# PATH CHECK
# ===============================
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo "➕ Adding ~/.local/bin to PATH"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

echo
echo "✅ Installation completed successfully!"
echo "➡️ Reboot or log out / log in is recommended."
echo "➡️ Enjoy this Niri setup!"
