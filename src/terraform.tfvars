################# Variables GLOBALES ##################
bucket_name = "xcoin-closedai-tfstates-bucket"
dynamodb_table = "terraform-state-lock"

tags = {
  "owner"       = "ClosedAI"
  "devops"      = "Gonzalo Santiago Da Costa"
  "info_app"    = "cryptoCoin"
  "cloud"       = "AWS"
  "region"      = "us-east-1"
  "IAC"         = "Terraform"
  "IAC_Version" = "v1.8.2"
  env           = "Produccion"
}
