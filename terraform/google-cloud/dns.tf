module "dns_zone" {
  source           = "guerzon/gcp/modules//dnszone"
  version          = "1.0.0"
  zone_name        = "homelab"
  zone_dns_name    = var.public_zone_dns
  zone_description = "Homelab DNS zone"
  zone_type        = "public"
  cloud_logging    = true
}

module "dns_record_server1" {
  source         = "guerzon/gcp/modules//dnsrecord"
  managed_zone   = module.dns_zone.dns_zone
  record_name    = "server1.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.131"]
  record_ttl     = 60
}

module "dns_record_server2" {
  source         = "guerzon/gcp/modules//dnsrecord"
  managed_zone   = module.dns_zone.dns_zone
  record_name    = "server2.${var.public_zone_dns}"
  record_type    = "A"
  record_content = ["192.168.133.132"]
  record_ttl     = 60
}

module "dns_record_jenkins" {
  source         = "guerzon/gcp/modules//dnsrecord"
  managed_zone   = module.dns_zone.dns_zone
  record_name    = "jenkins.${var.public_zone_dns}"
  record_type    = "CNAME"
  record_content = ["server1.${var.public_zone_dns}"]
  record_ttl     = 60
}