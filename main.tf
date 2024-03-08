provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "vpc" {
  source                       = "./vpc"
  #vpc_cidr                     = "10.0.0.0/16"
  public_subnet_az1_cidr       = "10.0.1.0/24"
  public_subnet_az2_cidr       = "10.0.128.0/24"
}
module "lb" {
    source = "./lb"
    sg_id = module.vpc.aws_security_group_id
    subnet_id_1 = module.vpc.aws_subnet
    subnet_id_2 = module.vpc.aws_subnet_2_id
    target_id = module.ec2.instance_id
    vpc_id = module.vpc.vpc_id
}
module "ec2" {
    source = "./ec2"
    subnet_id = module.vpc.aws_subnet
   security_group_id= [module.vpc.aws_security_group_id]
  
}