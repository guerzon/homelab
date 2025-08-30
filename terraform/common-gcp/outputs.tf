output "dns_zone_nameservers" {
  description = "The nameservers to delegate the zone."
  value       = module.dns_zone_sreafterhours.name_servers
}

output "vpc_network" {
  description = "The VPC network created."
  value       = module.vpc.network
}

output "singapore_subnet" {
  description = "Self-link to the Singapore subnet created."
  value = module.subnets.subnets[var.region].self_link
}