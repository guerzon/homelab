module "dns_zone" {
  source           = "guerzon/gcp/modules//dnszone"
  version          = "1.0.0"
  zone_name        = "apps"
  zone_dns_name    = var.public_zone_dns
  zone_description = "Applications DNS zone"
  zone_type        = "public"
}

########## Start - Certbot ##########
module "dns_record_certbot" {
  source       = "guerzon/gcp/modules//dnsrecord"
  version      = "1.0.0"
  managed_zone = module.dns_zone.dns_zone
  record_name  = "_acme-challenge.${var.public_zone_dns}"
  record_type  = "TXT"
  record_content = [
    "HrJuVsVmpv8cUzukAC5daw0wJNE3c0aYfgGykNQh6fw"
  ]
  record_ttl = 60
}
########## End - Certbot ##########