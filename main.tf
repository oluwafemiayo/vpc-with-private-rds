#https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/4.0.0


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "assessment"
  cidr = var.vpc_cidr

  azs = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets =  var.vpc_public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  
  tags = {
    Environment = "development"
  }

  enable_dns_hostnames = var.dns_hostnames

}
