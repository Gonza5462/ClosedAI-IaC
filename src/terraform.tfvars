################# S3 ##################
bucket_name = "tfstates-bucket"
description = "Bucket con los archivos .tfstates"
#env         = ["develop", "testing", "master"]

################# TAGS GLOBALES ##################
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
