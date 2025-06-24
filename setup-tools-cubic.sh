#!/bin/bash
set -e

echo "🚀 Starting DevOps Toolchain Setup Inside Cubic chroot..."

# Pastikan system update
apt update && apt upgrade -y
apt install -y curl gnupg lsb-release apt-transport-https ca-certificates software-properties-common wget unzip

# === Docker Engine + CLI ===
echo "🐳 Installing Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# === Docker Compose Standalone (Legacy) ===
echo "🧱 Installing Docker Compose standalone..."
curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# === kubectl ===
echo "☸️ Installing kubectl..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubectl

# === Helm ===
echo "🎯 Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# === Minikube ===
echo "🔧 Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# === Terraform ===
echo "📐 Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install -y terraform

# === Ansible ===
echo "📡 Installing Ansible..."
apt install -y ansible

# === Recommended CLI Tools ===
echo "🔧 Installing useful CLI tools..."
apt install -y tmux bat ripgrep fzf zoxide

# === Clean Up ===
echo "🧹 Cleaning up..."
apt clean
rm -rf /var/lib/apt/lists/*

echo "✅ DevOps Toolchain Setup in Cubic chroot complete."
