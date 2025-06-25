#!/usr/bin/env bash
set -e

echo "🔒 Install LY Login Manager..."

# Update dan dependencies
sudo apt update
sudo apt install -y build-essential git libpam0g-dev libxcb-xkb-dev libxkbcommon-dev libxcb1-dev libxcb-util0-dev libevdev-dev libudev-dev libxcb-xtest0-dev snapd

echo "🧹 Bersih-bersih Zig lama..."
rm -rf /opt/zig
rm -f /usr/local/bin/zig
apt remove --purge zig -y || true

echo "⬇️ Download dan install Zig 0.14.1..."
cd /opt
wget https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz
tar -xf zig-linux-x86_64-0.14.0.tar.xz
mv zig-linux-x86_64-0.14.0 zig
ln -s /opt/zig/zig /usr/local/bin/zig

echo "✅ Cek versi Zig..."
zig version

echo "⚙️ Clone & build LY..."
cd /tmp
rm -rf ly
git clone https://codeberg.org/fairyglade/ly.git
cd ly
zig build
zig build install

echo "✅ LY selesai diinstall."
echo "🔧 Setup LY supaya auto aktif pas boot..."
# Pastikan systemd structure ada
mkdir -p /etc/systemd/system/getty.target.wants
# Bikin symlink manual kayak systemctl enable biasanya
ln -sf /etc/systemd/system/ly.service /etc/systemd/system/getty.target.wants/ly.service
echo "✅ LY bakal otomatis aktif pas boot di sistem final."
