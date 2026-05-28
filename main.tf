module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = "aws-vpc-main"

}

module "igw" {
  source = "./modules/igw"

  vpc_id = module.vpc.vpc_id
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

module "nat" {
  source = "./modules/nat"

  public_subnet_ids = module.subnets.public_subnet_ids
  environment       = var.environment
}

module "route_tables" {
  source = "./modules/route-tables"

  vpc_id              = module.vpc.vpc_id
  environment         = var.environment
  internet_gateway_id = module.igw.igw_id
  nat_gateway_ids     = module.nat.nat_gateway_ids
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

module "load_balancer" {
  source = "./modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  security_group_ids = [module.security_groups.alb_security_group_id]
  environment        = var.environment
}

module "autoscaling" {
  source = "./modules/asg"

  private_subnet_ids        = module.subnets.private_subnet_ids
  security_group_ids        = [module.security_groups.app_security_group_id]
  target_group_arns         = [module.load_balancer.target_group_arn]
  instance_type             = var.ec2_instance_type
  autoscaling_group_name    = var.autoscaling_group_name
  launch_configuration_name = var.launch_configuration_name
  environment               = var.environment
}

module "ec2_instances" {
  source = "./modules/ec2"

  private_subnet_ids = module.subnets.private_subnet_ids
  security_group_ids = [module.security_groups.app_security_group_id]
  instance_type      = var.ec2_instance_type
  environment        = var.environment
}