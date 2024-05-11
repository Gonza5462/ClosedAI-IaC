terraform {
  backend "s3" {
    bucket         = "xcoin-closedai-tfstates-bucket"
    dynamodb_table = "terraform-state-locks"
    key            = "global/statefile/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.47.0"
    }
  }
  required_version = "~>1.8.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

module "ec2_backend" {
  source = "./modules/ec2"
}

module "s3-tfstate" {
  source             = "./modules/s3-tfstate"
  bucket_name        = var.bucket_name
  dynamodb_table     = var.dynamodb_table
  bucket_description = var.bucket_description
  #bucket_name    = "xcoin-closedai-tfstates-bucket"
  #description    = "Bucket con los archivos .tfstates"
  #dynamodb_table = "terraform-state-lock"
}

module "rds" {
  source = "./modules/rds"
}

output "ec2_public_ip" {
  value = module.ec2_backend.ec2_public_ip
}

output "db_host" {
  value = module.rds.db_host
}

#module "terraform_state_backend" {
#  source = "cloudposse/tfstate-backend/aws"
#  version     = "1.4.1"
#  namespace  = "XCoin-prod"
#  stage      = "prod"
#  name       = "terraform" 
#  environment = "us-east-1"
#  attributes = ["state"]
#  terraform_backend_config_file_path = "."
#  terraform_backend_config_file_name = "backend.tf"
#  force_destroy                      = false
#} 
