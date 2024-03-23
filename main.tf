provider "aws" {
  region  = "ap-south-1"
  #profile = "default"
}

terraform {
  backend "s3" {
    bucket = "shubhamm-terraform-s3-bucket"
    key    = "terraform/remote/s3/terraform.tfstate"
    encrypt        = false
    region         = "ap-south-1"
    dynamodb_table = "my-dynamo-db-practice-1"
  }
}
/*variable "dynamodb_name" {
    default = "my-dynamo-db-practice-1"
  
}
variable "hash_key" {
    default = "LockID"
    type = string
  
}

resource "aws_dynamodb_table" "our-table" {
    name = var.dynamodb_name
    read_capacity = 5
    write_capacity = 5
    hash_key = var.hash_key
    attribute {
        name = var.hash_key
        type = "S"
    }
     tags = {
        Name = "Dynamo DB for locking and unlocking"
    }
}*/
module "vpc" {
  source                       = "./vpc"
  #vpc_cidr                     = "10.0.0.0/16"
  public_subnet_az1_cidr       = "10.0.1.0/24"
  public_subnet_az2_cidr       = "10.0.128.0/24"
}
module "kubernetes" {
    source = "./kubernetes"
    subnet_ids = [module.vpc.aws_subnet,module.vpc.aws_subnet_2_id]
    



  
}