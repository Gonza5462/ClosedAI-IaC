resource "aws_ecr_repository" "registry" {
  name                 = "xcoin-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
