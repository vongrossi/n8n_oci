provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

resource "oci_core_instance" "n8n_vm" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.A1.Flex"
  display_name        = "n8n-instance"
  source_details {
    source_type = "image"
    source_id   = var.image_id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet_id
  }
}
