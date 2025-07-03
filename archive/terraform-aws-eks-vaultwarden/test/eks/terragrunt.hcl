terraform {
    source = "git@github.com:guerzon/terraform-aws-modulescollection.git//vaultwarden-kubernetes/eks?ref=v1.4.0"
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
    k8s_version = "1.31"
    eks_cluster_name = "vaultwarden-${include.testvars.locals.environment}-eks"
    subnet_ids = dependency.vpc.outputs.private_subnet_ids
    node_groups = {
        general = {
            capacity_type = "ON_DEMAND"
            instance_type = ["t3a.xlarge"]
            scaling_config = {
                desired_size = 3
                max_size = 10
                min_size = 0
            }
        }
    }
    vpc_id = dependency.vpc.outputs.vpc_id
    region = "ap-southeast-1"
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        private_subnet_ids = ["subnet-1234", "subnet-4567", "subnet-7890"]
        vpc_id = "vpc98765"
    }
}
