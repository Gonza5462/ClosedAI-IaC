variable "tags" {
  description = "Tags para asignar a los recursos."
  type        = map(string)
}

variable "bucket_name" {
  description = "Nombre del bucket."
  type        = string
}

variable "dynamodb_table" {
  description = "Nombre del bucket."
  type        = string
}