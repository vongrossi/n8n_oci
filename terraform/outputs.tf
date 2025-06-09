output "n8n_public_ip" {
  description = "Public IP of the n8n instance"
  value       = oci_core_instance.n8n_instance.public_ip
}
