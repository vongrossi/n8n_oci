# 🌐 Configure NGINX with SSL for n8n

These optional steps let you serve n8n through HTTPS using a custom domain name.
You should already have n8n running via Docker on port **5678**.

---

## 1. Point your domain

1. In your DNS provider, create an **A record** pointing your domain (e.g. `n8n.example.com`) to your VM's public IP.
2. Wait for the DNS change to propagate before continuing.

---

## 2. Install NGINX and Certbot

Connect to your instance via SSH and install the packages:

```bash
sudo apt update
sudo apt install nginx certbot python3-certbot-nginx -y
```

Enable NGINX at boot:

```bash
sudo systemctl enable nginx --now
```

---

## 3. Create a reverse proxy config

Create `/etc/nginx/sites-available/n8n` with the following content
(replace `n8n.example.com` with your domain):

```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files $uri $uri/ =404;
    }
}
```

Activate the configuration and test:

```bash
sudo ln -s /etc/nginx/sites-available/n8n /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

You should now reach n8n via `http://n8n.example.com`.

---

## 4. Obtain a Let's Encrypt certificate

Run Certbot to request an SSL certificate and let it update the NGINX config:

```bash
sudo certbot --nginx -d n8n.example.com
```

Certbot will configure HTTPS and set up automatic renewal.
You can test renewal with:

```bash
sudo certbot renew --dry-run
```

Once complete, visit `https://n8n.example.com` and log in with the
credentials defined in your `docker-compose.yml`.

---

### Update n8n settings (optional)

To ensure n8n generates correct webhook URLs, add these environment variables
to the `n8n` service in your `docker-compose.yml`:

```yaml
    environment:
      - N8N_HOST=n8n.example.com
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://n8n.example.com/
```

Recreate the container after editing:

```bash
docker compose up -d
```

Your instance is now secured with HTTPS via NGINX.
