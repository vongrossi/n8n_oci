# Deploy n8n on Oracle Cloud (OCI) Free Tier
Automate workflows with n8n, deployed on an always-free OCI VM. Simple, secure, and no domain setup required.

## Features
- Free deployment using OCI Free Tier
- Fully automated with Terraform and Docker Compose
- Access n8n at `http://<public-ip>:5678`
- Secured with Basic Auth
- Optional SSL and domain support

## Setup Instructions
1. Clone the repo:
   ```bash
   git clone https://github.com/clementalo9/n8n_oci.git
   cd n8n_oci
   ```
2. Configure OCI credentials and variables.
3. Deploy infrastructure:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```
4. SSH into your VM and run:
   ```bash
   cd scripts
   ./install_n8n.sh
   ```
5. Open n8n at `http://<public-ip>:5678`

## Basic Auth Security
Customize credentials in `docker-compose.yml`.

## Optional: SSL & Domain
Guidelines included.
