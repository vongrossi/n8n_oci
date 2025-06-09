
variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}

variable "n8n_admin_user" {
  description = "n8n admin username"
  type        = string
}

variable "n8n_admin_password" {
  description = "n8n admin password"
  type        = string
  sensitive   = true
}
