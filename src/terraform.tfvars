
################# Variables GLOBALES ##################
bucket_name        = "xcoin-closedai-tfstates-bucket2"
dynamodb_table     = "terraform-state-lock2"
bucket_description = "Bucket con los archivos .tfstates"
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
