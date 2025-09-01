module "dns_record_node1" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.1"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name    = "node1.${var.domain_name}"
  record_type    = "A"
  record_content = [module.node1.public_ip]
  record_ttl     = 60
}

##### ACME Let's Encrypt #####

module "dns_record_acme" {
  source       = "guerzon/gcp/modules//dnsrecord"
  version      = "1.3.1"
  managed_zone = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name  = "_acme-challenge.${var.domain_name}"
  record_type  = "TXT"
  record_content = [
    "5RuJgis_x2YQa8cv7-Lq8IGfHG7trhnIqllq_z_Lmnk",
    "Rqgtl7P18ijxGZihP-T7C_ia4su5mGTvNhQ_wgc6qeQ"
  ]
  record_ttl = 60
}

##### Monitoring Stack and DB #####

module "dns_record_prometheus" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.1"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name    = "prometheus.${var.domain_name}"
  record_type    = "CNAME"
  record_content = ["node1.${var.domain_name}"]
  record_ttl     = 60
}

module "dns_record_grafana" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.1"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name    = "grafana.${var.domain_name}"
  record_type    = "CNAME"
  record_content = ["node1.${var.domain_name}"]
  record_ttl     = 60
}

module "dns_record_postgres" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.1"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name    = "postgres.${var.domain_name}"
  record_type    = "CNAME"
  record_content = ["node1.${var.domain_name}"]
  record_ttl     = 60
}

##### Monitoring Stack and DB #####

module "dns_record_sonarqube" {
  source         = "guerzon/gcp/modules//dnsrecord"
  version        = "1.3.1"
  managed_zone   = data.terraform_remote_state.common_gcp.outputs.dns_zone_sreafterhours
  record_name    = "sonarqube.${var.domain_name}"
  record_type    = "CNAME"
  record_content = ["node1.${var.domain_name}"]
  record_ttl     = 60
}