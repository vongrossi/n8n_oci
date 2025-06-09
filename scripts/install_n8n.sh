#!/bin/bash
set -euo pipefail

# Credentials for n8n basic auth are supplied by Terraform when rendering this
# template. They replace the previously hard-coded values.
N8N_BASIC_AUTH_USER="${n8n_user}"
N8N_BASIC_AUTH_PASSWORD="${n8n_password}"

# Escape special characters for sed replacement
ESCAPED_USER=$(printf '%s' "$N8N_BASIC_AUTH_USER" | sed -e 's/[\/&|]/\\&/g')
ESCAPED_PASSWORD=$(printf '%s' "$N8N_BASIC_AUTH_PASSWORD" | sed -e 's/[\/&|]/\\&/g')
sudo apt update && sudo apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
newgrp docker
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
SCRIPT_DIR="$(cd "$(dirname "$0")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR/.."
sudo sed -i "s|N8N_BASIC_AUTH_USER=.*|N8N_BASIC_AUTH_USER=${ESCAPED_USER}|" docker-compose.yml
sudo sed -i "s|N8N_BASIC_AUTH_PASSWORD=.*|N8N_BASIC_AUTH_PASSWORD=${ESCAPED_PASSWORD}|" docker-compose.yml
mkdir -p n8n_data
sudo chown -R 1000:1000 n8n_data
docker-compose up -d
