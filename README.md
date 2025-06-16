# 🚀 Deploy n8n for Free on Oracle Cloud (Always Free Tier)

This guide explains how to deploy [n8n](https://n8n.io/) on Oracle Cloud using a free VM and set it up with Docker and Nginx.

---

## 🔘 One-Click Deploy

You can deploy your n8n instance with a single click using the Oracle Cloud Resource Manager:

[![Deploy to Oracle Cloud](https://cloudmarketplace.oracle.com/marketplace/content?contentId=cloud-button)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/your-repo/n8n_oci/archive/refs/heads/main.zip)

---

## 🧾 Requirements

- Oracle Cloud Free Tier account
- SSH client (e.g., PuTTY or Bitvise)
- SSH key pair (the public key is automatically injected via `authorized_keys`)

---

## 🧩 After Deployment – Setup Steps

Once your instance is created, follow these steps:

### 1. Connect to your Instance

From Oracle Cloud Shell:

```bash
ssh -i ~/.ssh/id_rsa opc@<your-public-ip>
```

Replace `<your-public-ip>` with the one shown in the Resource Manager outputs.

> 💡 If using a private key from Windows, connect with Bitvise or PuTTY using the `.ppk` key format.

---

### 2. Update and Install Dependencies

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io docker-compose nginx ufw -y
sudo systemctl enable docker && sudo systemctl start docker
```

---

### 3. Clone the Configuration

```bash
git clone https://github.com/that-one-tom/n8n-on-oracle-vm.git
cd n8n-on-oracle-vm
```

---

### 4. Run n8n with Docker

```bash
docker compose up -d
```

Check logs:

```bash
docker logs n8n
```

---

### 5. Setup Nginx Reverse Proxy

Nginx is preconfigured in the project:

```bash
sudo cp n8n.conf /etc/nginx/sites-available/default
sudo nginx -t && sudo systemctl restart nginx
```

> This configuration redirects HTTP requests to `localhost:5678`.

---

### 6. Open n8n in Your Browser

Visit:

```
http://<your-public-ip>/setup
```

You should reach the n8n setup page.

---

## 🧱 Optional – Use a Domain Name

If you have a domain name, point an A record to your instance's public IP and update your Nginx config accordingly.

---

## 🛑 To Stop or Restart

From the `n8n-on-oracle-vm` directory:

```bash
docker compose down       # stop
docker compose up -d      # restart
```

---

## 📏 Oracle Cloud Free Tier Limits Reminder

- 1 VM instance: `VM.Standard.A1.Flex`
- Up to 4 OCPUs and 24 GB RAM total
- Always Free Public IP available
- Storage: 200 GB block volume free
- 10 TB/month outbound data transfer

---

## 🤝 Credits

Thanks to [that-one-tom](https://github.com/that-one-tom) for the original tutorial and scripts.

