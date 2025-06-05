variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the instance"
  type        = string
}

variable "n8n_admin_user" {
  description = "n8n Basic Auth Username"
  type        = string
  default     = "admin"
}

variable "n8n_admin_password" {
  description = "n8n Basic Auth Password"
  type        = string
  default     = "adminpassword"
  sensitive   = true
}