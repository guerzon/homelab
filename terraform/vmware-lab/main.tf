data "terraform_remote_state" "common_gcp" {
  backend = "gcs"
  config = {
    bucket = "terraform-gcp-portfolio-465603"
    prefix = "terraform/common"
  }
}

##### Machines #####

module "dns_record_computadora" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "computadora.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.129"]
  record_ttl     = 60
}

module "dns_record_server1" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "server1.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.131"]
  record_ttl     = 60
}

module "dns_record_server2" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "server2.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.132"]
  record_ttl     = 60
}

module "dns_record_winwin" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "winwin.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.155"]
  record_ttl     = 60
}

##### Monitoring Stack and DB #####

module "dns_record_prometheus" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "prometheus.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}

module "dns_record_grafana" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "grafana.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}

module "dns_record_postgres" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "postgres.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}

##### CI/CD #####

module "dns_record_jenkins" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "jenkins.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}

module "dns_record_jfrog" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "jfrog.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}

module "dns_record_sonar" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.0"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone
  record_name    = "sonar.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}