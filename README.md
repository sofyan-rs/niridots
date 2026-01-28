# 🌌 My Niri Dots

A minimal yet powerful Niri setup crafted for elegance, performance, and customization. Built with precision and modern Wayland aesthetics.

## ✨ Features

- 🌀 Scrollable tiling with **Niri**
- 🖼️ Wallpaper management using **swww** & **Waypaper**
- 💻 Terminal : **Alacritty**, GPU-accelerated and fast
- 📟 Clean, informative **Waybar**
- 🔍 Application launcher using **Rofi**
- 🧾 Fast system info via **Fastfetch**
- 💨 Smooth transitions and animations
- 📡 Network and 🔵 Bluetooth tray applets
- 🔒 Screen locking with **Swaylock**

## 📸 Screenshots

![Desktop](screenshots/ss-1.png)

## ⚙️ Requirements

- [**Fedora Workstation 39+**](https://www.fedoraproject.org/)
- [**Niri**](https://github.com/YaLTeR/niri)
- `alacritty` – terminal emulator
- `swww` – wallpaper daemon
- `waypaper` – GUI wallpaper manager
- `fastfetch` – for fetching system info
- `waybar`, `rofi` – bar and launcher
- `swaylock` – screen locker
- `network-manager-applet`, `blueman` – for tray support
- `mako` - for notifications

## 💻 Installation

### Auto Installation

```bash
git clone https://github.com/sofyan-rs/niridots.git
cd niridots
chmod +x install.sh
./install.sh
```

### Manual Installation

- Install requirements

```bash
# install requirements
sudo dnf install niri
sudo dnf install rofi
sudo dnf install waybar
sudo dnf install power-profiles-daemon
sudo dnf install grim slurp wl-clipboard
# wallpapers
sudo dnf install swww waypaper
# notification daemon
sudo dnf install mako
sudo dnf install python3-pydbus
# network manager
sudo dnf install NetworkManager network-manager-applet
# bluetooth manager
sudo dnf install bluez bluez-tools blueman
# lock screen
sudo dnf install swaylock
# terminal
sudo dnf install alacritty
# fastfetch
sudo dnf install fastfetch
# apply gtk-theme
sudo dnf install nwg-look
sudo dnf install adw-gtk3-theme
sudo flatpak override --filesystem=xdg-data/themes
sudo flatpak mask org.gtk.Gtk3theme.adw-gtk3-dark
```

- Clone this repository

```bash
git clone https://github.com/sofyan-rs/niridots.git
cd niridots
```

- Copy all config folder to **~/.config**

```bash
cp -r .config/* ~/.config/
```

- Copy all fonts to **~/.local/share/fonts**

```bash
mkdir -p ~/.local/share/fonts
cp -r .local/share/fonts/* ~/.local/share/fonts/
fc-cache -fv
```

- Copy all icons to **~/.local/share/icons** 

```bash
mkdir -p ~/.local/share/icons
cp -r .local/share/icons/* ~/.local/share/icons/
```

- Copy **.local/bin/waybar-mako-notif.py** to **~/.local/bin**

```bash
mkdir -p ~/.local/bin
cp .local/bin/waybar-mako-notif.py ~/.local/bin/
chmod +x ~/.local/bin/waybar-mako-notif.py
```

- Set GTK-Theme using **nwg-look**
- Reboot

## 🔧 Customization

**Wallpapers:** Put your favorites in the **Pictures/Wallpapers/** folder and configure using **waypaper**.

**Keybindings:** Adjust bindings in `~/.config/niri/config.kdl`.

## ❤️ Credits

### Special thanks to:

**Fedora** for best Distro

**Niri** for the innovative Wayland compositor

The open-source community for endless inspiration
