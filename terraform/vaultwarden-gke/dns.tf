# module "dns_record_certbot" {
#   source       = "guerzon/gcp/modules//dnsrecord"
#   version      = "1.0.0"
#   managed_zone = data.terraform_remote_state.common_gcp.outputs.dns_zone
#   record_name  = "_acme-challenge.${var.public_zone_dns}"
#   record_type  = "TXT"
#   record_content = [
#     "HrJuVsVmpv8cUzukAC5daw0wJNE3c0aYfgGykNQh6fw"
#   ]
#   record_ttl = 60
# }