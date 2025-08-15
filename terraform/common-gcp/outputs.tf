output "dns_zone_nameservers" {
  description = "The nameservers to delegate the zone."
  value       = module.dns_zone.name_servers
}

output "dns_zone" {
  description = "The DNS zone created."
  value       = module.dns_zone.dns_zone
}

output "vpc_network" {
  description = "The VPC network created."
  value       = module.vpc.network
}