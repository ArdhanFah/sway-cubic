#!/usr/bin/env bash
set -e

echo "🚀 Starting Full RunfluxOS Setup..."

apt update && apt upgrade -y

echo "🔧 Setup Tools..."
./setup-tools-cubic.sh

echo "🔧 Setup Apps..."
./setup-apps-cubic.sh

echo "🎨 Setup Window Manager & Configs..."
./setup-wm-cubic.sh

echo "🔒 Setup Login Manager..."
./setup-login-cubic.sh

echo "🎨 Setup MOTD..."
./setup-motd-cubic.sh

echo "✅ Semua setup selesai."
