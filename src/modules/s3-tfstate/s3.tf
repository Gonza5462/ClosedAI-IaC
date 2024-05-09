resource "aws_s3_bucket" "tfstate_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    "Description" = var.bucket_description
  }
}

resource "aws_s3_bucket_versioning" "tfstate_version" {
    bucket = aws_s3_bucket.tfstate_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstates_bucket_encryption" {
  bucket = aws_s3_bucket.tfstate_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
   hash_key = "LockID"
   attribute {
     name = "LockID"
     type = "S"
   }
}
