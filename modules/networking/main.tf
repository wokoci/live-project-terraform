#data "aws_availability_zone" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr    = "10.0.0.0/16"
  name    = "${var.namespace}-vpc"
  version = "3.18.1"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  create_database_subnet_group = true

  single_nat_gateway           = true

  enable_nat_gateway = true
  tags               = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "lb_sg" {

  source       = "terraform-in-action/sg/aws"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      port       = 80
      cidr_block = ["0.0.0.0/0"]
    }
  ]
}

module "websvr_sg" {

  source       = "terraform-in-action/sg/aws"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      port           = 8080
      security_group = [module.lb_sg.security_group.id]
    }, {
      port       = 22
      cidr_block = ["10.0.0.0/16"]
    }
  ]
}

module "db_sg" {
  source       = "terraform-in-action/sg/aws"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      port           = 3306
      security_group = [module.websvr_sg.security_group.id]
    }
  ]
}

