 data "aws_key_pair" "xcoin_mongodb_key" {
   key_name = "xcoin-secret"
 }

 data "aws_key_pair" "github_runner_key" {
   key_name = "xcoin-secret"
 }