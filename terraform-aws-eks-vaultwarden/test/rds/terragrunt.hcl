terraform {
    source = "git@github.com:guerzon/terraform-aws-modulescollection.git//vaultwarden-kubernetes/database?ref=v1.4.0"
}

include "root" {
    path = find_in_parent_folders()
}

include "testvars" {
    path = find_in_parent_folders("vars.hcl")
    expose = true
    merge_strategy = "no_merge"
}

inputs = {
    environment = include.testvars.locals.environment
    vpc_id = dependency.vpc.outputs.vpc_id
    vpc_cidr = dependency.vpc.outputs.vpc_cidr
    database_subnets = dependency.vpc.outputs.private_subnet_ids
    database_type = "postgres"
    database_version = "17.1"
    storage = {
        initial = 100
        maximum = 500
    }
    instance_class = "db.t4g.small"
    master_user = {
        username = "warden"
        password = "Sup3rs3cretPassword"
    }
    database_name = "vaultwarden"
    minor_auto_upgrade = true
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        private_subnet_ids = ["subnet-1234", "subnet-4567", "subnet-7890"]
        vpc_id = "vpc98765"
        vpc_cidr = "10.0.0.0/8"
    }
}
