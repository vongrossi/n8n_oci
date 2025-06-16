# n8n on Oracle Cloud (Always Free)

> One-click deployment of n8n on Oracle Cloud Free Tier.

[![Deploy to Oracle Cloud](https://github.com/clementalo9/oke_A1/blob/main/images/Deploy2OCI.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/clementalo9/n8n_oci/archive/refs/heads/main.zip)

## ✨ Features
- Runs on VM.Standard.A1.Flex (ARM, free tier)
- Public IP access on port 5678
- SSH access on port 22
- Basic auth enabled out of the box
- Deployable via Oracle Cloud Resource Manager or Terraform CLI

## 📝 Prerequisites
You must first create a free Oracle Cloud account here:  
👉 https://www.oracle.com/cloud/free/

Oracle requires a valid credit card for identity verification, but as long as you stay in the Always Free tier, you will not be charged.

This project uses the `VM.Standard.A1.Flex` instance type, which is included in the Always Free tier with the following limits:
- **4 OCPUs**
- **24 GB RAM**
- **2 VMs max per tenancy**

n8n will run comfortably within those limits.

## 🚀 Deployment Steps

1. Click the **Deploy to Oracle Cloud** button above.
2. Upload your **SSH Public Key** when prompted.
3. Wait for the stack to finish provisioning (about 2–4 minutes).

## 🔐 Connect to your Instance

From the **Oracle Cloud Shell**:

```bash
ssh -i ~/.ssh/YOUR_PRIVATE_KEY opc@<PUBLIC_IP>
```

Replace `<PUBLIC_IP>` with the IP address shown at the end of deployment. If you're using **Windows**, connect using **PuTTY** or **Bitvise SSH Client** with your private key.

## 🧰 Install Docker & n8n

Once connected to your VM:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose nginx
sudo usermod -aG docker $USER
```

Log out and log in again (or run `newgrp docker`) to apply Docker permissions.

Create the `docker-compose.yml` file:

```bash
mkdir ~/n8n && cd ~/n8n
nano docker-compose.yml
```

Paste the following:

```yaml
version: "3"

services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=adminpassword
      - N8N_HOST=your_public_ip
      - N8N_PORT=5678
    volumes:
      - ~/.n8n:/home/node/.n8n
```

Start n8n:

```bash
docker compose up -d
```

## 🌐 Configure NGINX (Optional, for Port 80)

```bash
sudo nano /etc/nginx/sites-available/n8n
```

Paste:

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:5678/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Then enable:

```bash
sudo ln -s /etc/nginx/sites-available/n8n /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx
```

Now you can access n8n at:
```
http://<PUBLIC_IP> or http://<PUBLIC_IP>:5678
```

## 🛑 Stopping n8n

```bash
cd ~/n8n
docker compose down
```

---

## 📦 Credits

Based on the [tutorial](https://github.com/that-one-tom/n8n-on-oracle-vm) by @that-one-tom.
