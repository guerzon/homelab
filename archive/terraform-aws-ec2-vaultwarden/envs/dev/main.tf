module "vpc" {
  source             = "../../modules/network"
  environment        = "dev"
  vpc_cidr_block     = "10.10.0.0/16"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets    = ["10.10.0.0/19", "10.10.32.0/19", "10.10.64.0/19"]
  public_subnets     = ["10.10.96.0/19", "10.10.128.0/19", "10.10.160.0/19"]
}

module "rds" {
  source           = "../../modules/database"
  environment      = "dev"
  vpc_id           = module.vpc.vpc_id
  vpc_cidr         = module.vpc.vpc_cidr
  database_subnets = module.vpc.private_subnet_ids
  database_type    = "postgres"
  database_version = "17.1"
  storage = {
    initial = 100
    maximum = 500
  }
  instance_class = "db.t3.micro"
  master_user = {
    username = "warden"
    password = "Sup3rs3cretPassword"
  }
  database_name      = "vaultwarden"
  minor_auto_upgrade = true
}

module "ec2" {
  source            = "../../modules/server"
  environment       = "dev"
  ec2_instance      = "t2.micro"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.public_subnet_ids[0]
  availability_zone = "ap-southeast-1a"
}
