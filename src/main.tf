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

module "sqs" {
  source = "./modules/sqs"
}

module "s3-tfstate" {
  source             = "./modules/s3-tfstate"
  bucket_name        = var.bucket_name
  dynamodb_table     = var.dynamodb_table
  bucket_description = var.bucket_description
}

# module "ecr" {
#   source = "./modules/ecr"
# }

# module "ecsCluster" {
#   source = "./modules/ecs"

#   app_cluster_name   = var.app_cluster_name
#   availability_zones = var.availability_zones
#   app_task_famliy    = var.app_task_famliy
#   ecr_repo_url       = module.ecr.repository_url
#   container_port     = var.container_port
#   app_task_name      = var.app_task_name

#   application_load_balancer_name = var.application_load_balancer_name
#   target_group_name              = var.target_group_name
#   app_service_name               = var.app_service_name
# }

output "ec2_public_ip" {
  value = module.ec2_db.ec2_public_ip
}

output "sqs" {
  value = module.sqs
}

output "EIP" {
  value = module.ec2_db.EIP
}

# output "ECR_Repository" {
#   value = module.ecr.repository_url
# }
