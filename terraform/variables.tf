variable "tenancy_ocid" {
  description = "OCID du tenancy Oracle Cloud"
  type        = string
}

variable "ssh_public_key" {
  description = "Contenu de votre clé publique SSH (ex: id_rsa.pub)"
  type        = string
}

variable "n8n_admin_user" {
  description = "Nom d'utilisateur administrateur pour N8n"
  type        = string
  sensitive   = true
}

variable "n8n_admin_password" {
  description = "Mot de passe administrateur pour N8n"
  type        = string
  sensitive   = true
}
