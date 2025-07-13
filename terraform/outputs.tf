output "dns_zone_nameservers" {
  description = "The nameservers to delegate the zone."
  value       = module.dns_zone.name_servers
}