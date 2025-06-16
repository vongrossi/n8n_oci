# 🚀 Deploy n8n on Oracle Cloud Free Tier

This guide helps you deploy [n8n](https://n8n.io) for free on Oracle Cloud using the Always Free Tier with an ARM-based VM.  
You don’t need a domain name or SSL, but both can be added optionally for production use.

---

## 📦 Requirements

- A free Oracle Cloud account → [Sign up](https://www.oracle.com/cloud/free/)
- A private SSH key to access your VM
- Use of the **Always Free Tier** (ARM): VM.Standard.A1.Flex with:
  - 1 OCPU
  - 6 GB RAM
  - 50 GB block storage

When creating your Oracle Cloud account, you must provide a valid credit card for identity verification. You won't be charged as long as you stay within the Always Free tier.

This project uses the `VM.Standard.A1.Flex` instance type, which is part of the Always Free tier with the following limits:
- **4 OCPUs**
- **24 GB RAM**
- **2 VMs max per tenancy**

n8n will run comfortably within those limits.

---

## ☁️ Deploy to Oracle Cloud

You can use the button below to provision the instance and network infrastructure:

[![Deploy to Oracle Cloud](https://github.com/clementalo9/n8n_oci/blob/main/img/Deploy%20to%20Oracle%20Cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/clementalo9/n8n_oci/archive/refs/heads/main.zip)

---

## 🔧 After Deployment: Connect to Your Instance

1. Go to the **Compute > Instances** section in the OCI console.
2. Copy the public IP of your instance.
3. Use your SSH key to connect via terminal or PuTTY:

### 🖥️ From Terminal (Linux/macOS)

```bash
ssh -i path/to/your/private.key opc@YOUR_PUBLIC_IP
```

> Replace `path/to/your/private.key` with the path to your private SSH key used during deployment.

---

## 🐳 Install Docker & Docker Compose

Once connected to your instance:

```bash
sudo apt update && sudo apt install docker.io docker-compose -y
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
newgrp docker
```

---

## 📂 Create the n8n Directory and Files

```bash
mkdir ~/n8n && cd ~/n8n
nano docker-compose.yml
```

Paste this content into `docker-compose.yml`:

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
      - N8N_BASIC_AUTH_PASSWORD=your_secure_password
    volumes:
      - ~/.n8n:/home/node/.n8n
```

Save and exit. Then launch:

```bash
docker compose up -d
```

---

## 🌐 Access Your n8n Editor

- Go to your browser and open:

```
http://YOUR_PUBLIC_IP:5678
```

> You will be prompted for the login and password defined in `docker-compose.yml`.

---

## 🔒 Optional: Enable HTTPS with a Custom Domain Name

By default, n8n is accessible via:

```
http://YOUR_PUBLIC_IP:5678
```

This is sufficient for most use cases, and does **not** require a domain name or reverse proxy.

### ✅ Do you want to use a custom domain and HTTPS?

If you prefer to access n8n securely via `https://yourdomain.com`, you may:

1. **Point your domain name** to your instance’s public IP (set A record).
2. **Install and configure NGINX** as a reverse proxy.
3. **Use Certbot** to generate a free SSL certificate.

> ⚠️ This part is optional. You can skip it if you don’t plan to use HTTPS or a custom domain.

---

## 📚 Advanced Configuration

See [`docs/nginx-ssl.md`](docs/nginx-ssl.md) for help with domain, NGINX setup, and HTTPS.

---

## 🙏 Acknowledgements

Based on the excellent guide by [@that-one-tom](https://github.com/that-one-tom/n8n-on-oracle-vm).
