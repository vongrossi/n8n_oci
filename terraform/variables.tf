variable "tenancy_ocid" {
  description = "OCI tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID"
  type        = string
}

variable "fingerprint" {
  description = "API fingerprint for the user key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private API signing key"
  type        = string
}

variable "region" {
  description = "OCI region where resources will be created"
  type        = string
}

variable "availability_domain" {
  description = "Availability domain for the compute instance"
  type        = string
}

variable "compartment_id" {
  description = "Compartment OCID containing the resources"
  type        = string
}

variable "image_id" {
  description = "Image OCID for the instance"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "subnet_id" {
  description = "Subnet OCID to attach to the instance"
  type        = string
}
