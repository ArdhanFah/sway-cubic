#!/usr/bin/env bash
set -e

echo "🔒 Install LY Login Manager..."

# Update dan dependencies
sudo apt update
sudo apt install -y build-essential git libpam0g-dev libxcb-xkb-dev libxkbcommon-dev libxcb1-dev libxcb-util0-dev libevdev-dev libudev-dev libxcb-xtest0-dev snapd

echo "✅ Pastikan dependency runtime LY terinstall..."
sudo apt install -y libpam0g libxcb1 libxcb-xkb1 libxkbcommon0 libevdev2 libudev1 libxcb-xtest0

echo "🧹 Bersih-bersih Zig lama..."
rm -rf /opt/zig
rm -f /usr/local/bin/zig
apt remove --purge zig -y || true

echo "⬇️ Download dan install Zig 0.14.1..."
cd /opt
wget https://ziglang.org/download/0.14.1/zig-x86_64-linux-0.14.1.tar.xz
tar -xf zig-x86_64-linux-0.14.1.tar.xz
mv zig-x86_64-linux-0.14.1 zig
ln -sf /opt/zig/zig /usr/local/bin/zig

echo "✅ Cek versi Zig..."
zig version

echo "⚙️ Clone & build LY..."
cd /tmp
rm -rf ly
git clone https://codeberg.org/fairyglade/ly.git
cd ly
zig build

echo "✅ Copy binary LY ke /usr/local/bin..."
cp zig-out/bin/ly /usr/local/bin/ly
chmod +x /usr/local/bin/ly

if [ ! -f /usr/local/bin/ly ]; then
    echo "❌ ERROR: Binary /usr/local/bin/ly gak ditemukan. Build gagal?"
    exit 1
fi

echo "🔧 Setup LY supaya auto aktif pas boot..."
mkdir -p /etc/systemd/system/getty.target.wants

cat <<EOF > /etc/systemd/system/ly.service
[Unit]
Description=LY Display Manager
After=systemd-user-sessions.service
After=systemd-logind.service
After=getty@tty1.service
ConditionPathExists=!/etc/nolive

[Service]
ExecStart=/usr/local/bin/ly
StandardInput=tty
TTYPath=/dev/tty1
Restart=always

[Install]
WantedBy=getty.target
EOF

ln -sf /etc/systemd/system/ly.service /etc/systemd/system/getty.target.wants/ly.service

echo "📁 Buat flag /etc/nolive supaya LY gak aktif di Live mode..."
echo "Hapus file ini setelah install untuk mengaktifkan LY." > /etc/nolive

echo "⚙️ Setup auto-hapus /etc/nolive di boot pertama hasil install..."

cat <<'EOF' > /usr/local/bin/cleanup-nolive.sh
#!/usr/bin/env bash
set -e
rm -f /etc/nolive
rm -f /etc/systemd/system/multi-user.target.wants/cleanup-nolive.service
EOF

chmod +x /usr/local/bin/cleanup-nolive.sh

cat <<EOF > /etc/systemd/system/cleanup-nolive.service
[Unit]
Description=Auto-hapus /etc/nolive di boot pertama
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/cleanup-nolive.sh

[Install]
WantedBy=multi-user.target
EOF

ln -sf /etc/systemd/system/cleanup-nolive.service /etc/systemd/system/multi-user.target.wants/cleanup-nolive.service

echo "✅ LY bakal otomatis aktif pas boot di sistem final."
