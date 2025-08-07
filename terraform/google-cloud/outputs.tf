output "dns_zone_nameservers" {
  description = "The nameservers to delegate the zone."
  value       = module.dns_zone.name_servers
}

# output "compute_instance_ip" {
#   description = "The public IP address attached to the instance."
#   value       = module.compute.public_ip
# }