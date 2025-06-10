variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

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

variable "image_ocid" {
  description = "The OCID of the OS image to use for the VM"
  type        = string
}

