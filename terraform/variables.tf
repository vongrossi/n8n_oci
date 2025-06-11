variable "tenancy_ocid" {
  description = "OCID of Oracle Cloud Tenancy"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "n8n_admin_user" {
  description = "Instance username"
  type        = string
  sensitive   = true
}

variable "n8n_admin_password" {
  description = "Instance password"
  type        = string
  sensitive   = true
}
