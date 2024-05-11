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


module "ec2_db" {
  source = "./modules/ec2"
}

module "s3-tfstate" {
  source             = "./modules/s3-tfstate"
  bucket_name        = var.bucket_name
  dynamodb_table     = var.dynamodb_table
  bucket_description = var.bucket_description
}

module "rds" {
  source = "./modules/rds"
}

module "ecr" {
  source = "./modules/ecr"
}

output "ec2_public_ip" {
  value = module.ec2_db.ec2_public_ip
}

output "db_host" {
  value = module.rds.db_host
}

output "EIP" {
  value = aws_eip.mongodb_eip.public_ip
}
