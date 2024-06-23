
################# Variables GLOBALES ##################

#################      S3 States     ##################
bucket_name        = "xcoin-closedai-tfstates-bucket2"
dynamodb_table     = "terraform-state-locks"
bucket_description = "Bucket con los archivos .tfstates"

#################         ECS        ##################
app_cluster_name               = "xcoin-app"
availability_zones             = ["us-east-1a", "us-east-1b", "us-east-1c"]
app_task_famliy                = "xapp-task"
container_port                 = 3000
app_task_name                  = "xapp-task"
application_load_balancer_name = "xapp-alb"
target_group_name              = "xapp-alb-tg"
app_service_name               = "xapp-service"

tags = {
  "owner"       = "ClosedAI"
  "devops"      = "Gonzalo Santiago Da Costa"
  "info_app"    = "cryptoCoin"
  "cloud"       = "AWS"
  "region"      = "us-east-1"
  "IAC"         = "Terraform"
  "IAC_Version" = "v1.8.2"
  env           = "Producción"
}
