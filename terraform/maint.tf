provider "oci" {}





variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

data "oci_identity_compartment" "root" {
  id = var.tenancy_ocid
}

locals {
  compartment_ocid = data.oci_identity_compartment.root.id
}

resource "oci_core_virtual_network" "n8n_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = local.compartment_ocid
  display_name   = "n8n-vcn"
  dns_label      = "n8nvcn"
}

resource "oci_core_internet_gateway" "n8n_igw" {
  compartment_id = local.compartment_ocid
  display_name   = "n8n-igw"
  vcn_id         = oci_core_virtual_network.n8n_vcn.id
}

resource "oci_core_route_table" "n8n_route_table" {
  compartment_id = local.compartment_ocid
  vcn_id         = oci_core_virtual_network.n8n_vcn.id
  display_name   = "n8n-rt"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.n8n_igw.id
  }
}

resource "oci_core_subnet" "n8n_subnet" {
  cidr_block        = "10.0.1.0/24"
  compartment_id    = local.compartment_ocid
  vcn_id            = oci_core_virtual_network.n8n_vcn.id
  display_name      = "n8n-subnet"
  route_table_id    = oci_core_route_table.n8n_route_table.id
  dns_label         = "n8nsubnet"
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_instance" "n8n_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = local.compartment_ocid
  display_name        = "n8n-instance"
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    memory_in_gbs = 4
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.n8n_subnet.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(templatefile("${path.module}/../scripts/install_n8n.sh", {
      n8n_user     = var.n8n_admin_user
      n8n_password = var.n8n_admin_password
    }))
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = local.compartment_ocid
}
