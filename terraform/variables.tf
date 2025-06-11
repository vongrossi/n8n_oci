variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "n8n_admin_user" {
  description = "Instance admin username"
  type        = string
  sensitive   = true
}

variable "n8n_admin_password" {
  description = "Instance admin password"
  type        = string
  sensitive   = true
}


variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}



