# n8n on Oracle Cloud (Always Free)

> One-click deployment of n8n on Oracle Cloud Free Tier.

[![Deploy to Oracle Cloud](https://raw.githubusercontent.com/oracle/oci-cloudnative/deploy-button/docs/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/clementalo9/n8n_oci/archive/refs/heads/main.zip)

## ✨ Features
- Runs on VM.Standard.A1.Flex (ARM, free tier)
- Public IP access on port 5678
- Basic auth enabled out of the box
- Deployable via Oracle Cloud Resource Manager or Terraform CLI

## 🚀 Quick Deploy (recommended)
Click the button above to deploy automatically in your Oracle tenancy.

1. Log into your Oracle Cloud account
2. Select your compartment
3. Launch the stack and follow the prompts

## 🔧 Manual Deployment
```bash
git clone https://github.com/clementalo9/n8n_oci.git
cd n8n_oci/terraform
terraform init
terraform apply
```

## 🔐 Default Credentials
- Username: `admin`
- Password: `adminpassword`

> Change them in `docker-compose.yml` after first deployment.

## 🌐 Accessing n8n
Go to `http://<your-instance-public-ip>:5678`

✅ Optional: You may configure a custom domain and SSL certificate with Certbot. While not required, it is strongly recommended for production.

## 📂 Structure
- `terraform/`: OCI resources (VCN, subnet, instance)
- `scripts/`: Cloud-init script with Docker + n8n setup

## 🛡️ SSL/TLS (optional)
You need a domain name to use Let's Encrypt. We recommend [DuckDNS](https://www.duckdns.org) for a free domain name and simple DNS.

## 📜 License
MIT
```

---

## ✅ Final Check
- Ports 22 and 5678 must be open
- Public IP provided by OCI is sufficient to access the UI
- Domain + SSL optional but recommended for production