variable "admin_username" {
  description = "Username for accessing the application web interface"
  type        = string
}

variable "admin_password" {
  description = "Password for accessing the application web interface"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key to access the instance"
  type        = string
}
