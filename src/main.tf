terraform {
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
  source      = "./modules/s3-tfstate"
  bucket_name = "xcoin-closedai-tfstates-bucket"
  description = "Bucket con los archivos .tfstates"

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
