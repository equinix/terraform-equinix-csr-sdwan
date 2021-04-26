provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "csr-sdwan" {
  source               = "equinix/csr-sdwan/equinix"
  version              = "1.0.0"
  name                 = "tf-csr-sdwan"
  metro_code           = var.metro_code_primary
  platform             = "large"
  software_package     = "PREMIER"
  license_file         = "/tmp/csrsdwan-pri.cfg"
  term_length          = 1
  notifications        = ["test@test.com"]
  throughput           = 1
  throughput_unit      = "Gbps"
  interface_count      = 24
  additional_bandwidth = 100
  site_id              = "435"
  system_ip_address    = "123.53.66.34"
  acl_template_id      = equinix_network_acl_template.csr-sdwan-pri.id
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    license_file         = "/tmp/csrsdwan-sec.cfg"
    additional_bandwidth = 100
    acl_template_id      = equinix_network_acl_template.csr-sdwan-sec.id
    site_id              = "488"
    system_ip_address    = "84.141.11.5"
  }
}

resource "equinix_network_acl_template" "csr-sdwan-pri" {
  name        = "tf-csr-sdwan-pri"
  description = "Primary CSR SDWAN ACL template"
  metro_code  = var.metro_code_primary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "csr-sdwan-sec" {
  name        = "tf-csr-sdwan-sec"
  description = "Secondary CSR SDWAN ACL template"
  metro_code  = var.metro_code_secondary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
