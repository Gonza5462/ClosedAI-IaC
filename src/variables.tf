#------------------------------ Variables Globales ------------------------------------#

# variable "env" {
#   description = "Ambiente"
#   type        = list(string)
# }

variable "tags" {
  description = "Tags para asignar a los recursos."
  type        = map(string)
}

#------------------------------ S3 ------------------------------------#

variable "bucket_name" {
  description = "Nombre del bucket."
  type        = string
}

variable "description" {
  description = "Descripcion por variable."
  type        = string
}
