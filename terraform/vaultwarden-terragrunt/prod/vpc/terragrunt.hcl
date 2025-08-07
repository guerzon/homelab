terraform {
    source = "git@github.com:guerzon/terraform-aws-modulescollection.git//vaultwarden-kubernetes/network?ref=v1.4.0"
}

include "root" {
    path = find_in_parent_folders()
}

include "prodvars" {
    path = find_in_parent_folders("vars.hcl")
    expose = true
    merge_strategy = "no_merge"
}

inputs = {
    environment = include.prodvars.locals.environment
    vpc_cidr_block = "10.200.0.0/16"
    availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
    private_subnets = ["10.200.0.0/19", "10.200.32.0/19", "10.200.64.0/19"]
    public_subnets = ["10.200.96.0/19", "10.200.128.0/19", "10.200.160.0/19"]
    eks_cluster_name = "vaultwarden-eks"
}