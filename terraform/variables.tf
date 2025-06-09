
variable "vm_admin_user" {
  description = "Username for the VM SSH login"
  type        = string
}

variable "vm_admin_password" {
  description = "Password for the VM SSH login"
  type        = string
  sensitive   = true
}

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
