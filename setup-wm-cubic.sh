#!/usr/bin/env bash
set -e

echo "🎨 Setup Window Manager & Configs..."

# Install Sway, Terminal, Bar, File Manager, Fonts
apt install -y sway swaybg swayidle xwayland foot waybar wofi thunar alacritty network-manager pavucontrol pulseaudio fonts-font-awesome fonts-jetbrains-mono brightnessctl grim slurp jq

# Copy Konfigurasi ke /etc/skel supaya otomatis masuk ke home user baru
echo "📁 Copy konfigurasi ke /etc/skel/.config"
mkdir -p /etc/skel/.config
cp -r .config/* /etc/skel/.config/

echo "🔤 Copy fonts tambahan ke /etc/skel"
mkdir -p /etc/skel/.local/share/fonts
cp -r .local/share/fonts/* /etc/skel/.local/share/fonts/
fc-cache -fv

echo "📁 Copy aplikasi ke /etc/skel/.local/share/applications"
mkdir -p /etc/skel/.local/share/applications
cp -r .local/share/applications/* /etc/skel/.local/share/applications/
update-desktop-database /etc/skel/.local/share/applications

echo "✅ Setup Window Manager selesai."

