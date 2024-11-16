terraform {
    source = "git@github.com:guerzon/terraform-aws-modulescollection.git//vaultwarden-kubernetes/network?ref=v1.1.0"
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
    vpc_cidr_block = "10.10.0.0/16"
    availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
    private_subnets = ["10.10.0.0/19", "10.10.32.0/19", "10.10.64.0/19"]
    public_subnets = ["10.10.96.0/19", "10.10.128.0/19", "10.10.160.0/19"]
    eks_cluster_name = "vaultwarden-${include.testvars.locals.environment}-${include.testvars.locals.eks_cluster_name}"
}