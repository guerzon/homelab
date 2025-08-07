# module "compute" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//computeinstance?ref=v1.2.0"
#   source      = "../../../Google-Cloud/terraform-modules-gcp/computeinstance"
#   server_name = "prometheus-grafana-study"

#   network_name = module.vpc.network_name
#   subnetwork   = lookup(module.subnet.subnets, "singapore-subnet").id
#   environment  = "dev"
#   region       = var.region
#   zone         = var.preferred_zone

#   compute_engine_sa_name  = "study-serviceaccount"
#   instance_type           = "e2-standard-2"
#   tags                    = ["study"]
#   vm_instance_image       = "rocky-linux-9-v20250709"
#   public_instance         = true
#   metadata_startup_script = <<-EOT
#     #!/bin/bash
#     set +x
#     echo "Running startup script for VM"
#     sudo useradd lester
#     sudo mkdir /home/lester
#     sudo usermod -s /bin/bash -d /home/lester lester
#     echo "lester ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/lester
#     sudo mkdir /home/lester/.ssh && sudo chmod 0700 /home/lester/.ssh
#     echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwK/xnmtJK7M21ZdQXAfEwEZgApyV5s7UhyK1eIa3HCqY54PKrS4AaJKWRFn1Qa60nZno6OQV0BlN5bvXN7IjSdqzcxP8Dxb0KVn5ygwgf31CnUhbZ5Ug/4g93RV9hWBQLAebvzV+96JEVLEvtvH7jf8GulG6Y+YQyDTnAqibLlDrlu6JpDw4CpXLUS87YdcOmMVyUhjED4i4rfGril9DYKnOwn1hcDtYg8CCKEtMHb3JfmuaTVpoR8xZR106ibYnuxr3uWXVsGl48v/XIYlH8RBr8wcPK8qTgiCRkk2jlzBRG1lB9vTZEfjGhGCmwjdvOkyrS8fd5ulDx4KY8+pnrQx1hH1hTjIIn2f2lrJZn4wBx06ZcZylSZsGdPBTkHm5TBgzR1vE7M9IFdiVqXDS8xZsVkm+A8F0to6eJWzN6HUBNlc8sBEYIQlPeOXqNZHtsfTQ6o9iFlIuqY9sRvxBcWlf4E8r4LVPHA0u/Elddlj67jwtZUVkQa4Uny3e6OZU= lester@computadora" \
#       | sudo tee /home/lester/.ssh/authorized_keys
#     sudo chown -R lester:lester /home/lester
#     echo "Startup script completed"
#   EOT
#   allowed_ip_ranges       = [var.my_ip]
# }

# module "dns_record_prometheus" {
#   source         = "../../../Google-Cloud/terraform-modules-gcp/dnsrecord"
#   managed_zone   = module.dns_zone.dns_zone
#   record_name    = "prometheus.${var.public_zone_dns}"
#   record_type    = "A"
#   record_content = [module.compute.public_ip]
#   record_ttl     = 60
# }

# module "dns_record_grafana" {
#   source         = "../../../Google-Cloud/terraform-modules-gcp/dnsrecord"
#   managed_zone   = module.dns_zone.dns_zone
#   record_name    = "grafana.${var.public_zone_dns}"
#   record_type    = "A"
#   record_content = [module.compute.public_ip]
#   record_ttl     = 60
# }

# module "dns_record_certbot" {
#   source       = "../../../Google-Cloud/terraform-modules-gcp/dnsrecord"
#   managed_zone = module.dns_zone.dns_zone
#   record_name  = "_acme-challenge.${var.public_zone_dns}"
#   record_type  = "TXT"
#   record_content = [
#     "HrJuVsVmpv8cUzukAC5daw0wJNE3c0aYfgGykNQh6fw"
#   ]
#   record_ttl = 60
# }