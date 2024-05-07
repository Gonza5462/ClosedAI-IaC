resource "aws_s3_bucket" "tfstates_bucket" {
  bucket = var.bucket_name

  tags = {
    "Description" = "${var.description}"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstates_bucket_encryption" {
  bucket = aws_s3_bucket.tfstates_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}