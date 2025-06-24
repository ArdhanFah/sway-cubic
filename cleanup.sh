#!/usr/bin/env bash
set -e

echo "🧹 Starting Full Cleanup (Cubic Edition)..."

# 1. Clean APT Cache
echo "🧹 Cleaning APT cache..."
apt clean
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt/archives/*

# 2. Clean Snap Cache (Kalau ada)
echo "🧹 Cleaning Snap cache..."
rm -rf /var/lib/snapd/snaps/*
rm -rf /home/*/snap || true

# 3. Hapus Source Code Build-an yang Umum
echo "🧹 Removing leftover source code..."
rm -rf /root/ly /root/swayfx /root/wlroots /root/subprojects /root/build /root/Downloads/*
rm -rf /opt/runflux-setup/temporary-build

# Kalau pakai user skeleton /etc/skel, bersihin juga:
rm -rf /etc/skel/ly /etc/skel/swayfx /etc/skel/wlroots /etc/skel/subprojects /etc/skel/build /etc/skel/Downloads/*

# 4. Clean Log System
echo "🧹 Cleaning system logs..."
journalctl --vacuum-time=1s || true
rm -rf /var/log/*

# 5. Clean Temporary Files
echo "🧹 Cleaning /tmp..."
rm -rf /tmp/*

# 6. Clean History User
echo "🧹 Cleaning history..."
rm -rf /root/.bash_history /root/.zsh_history /root/.cache /root/.npm /root/.wget-hsts
rm -rf /etc/skel/.bash_history /etc/skel/.zsh_history /etc/skel/.cache /etc/skel/.npm /etc/skel/.wget-hsts

# 7. Clean Thumbnail Cache
echo "🧹 Cleaning thumbnails..."
rm -rf /root/.cache/thumbnails/*
rm -rf /etc/skel/.cache/thumbnails/*

# 8. Optional: Remove Build Tools kalau Produksi
# echo "🧹 Optional: Removing build tools..."
# apt purge -y build-essential meson ninja-build cmake gcc g++ make
# apt autoremove -y

# 9. Rebuild Font Cache
echo "🧹 Rebuilding font cache..."
fc-cache -fv

echo "✅ Cleanup selesai. ISO atau sistem jadi lebih ramping."
