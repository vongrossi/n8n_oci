variable "tenancy_ocid" {
  description = "OCID of Oracle Cloud Tenancy"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "ad_index" {
  description = "index of AD: 0 = AD-1, 1 = AD-2, 2 = AD-3"
  type        = number
  default     = 0
}


