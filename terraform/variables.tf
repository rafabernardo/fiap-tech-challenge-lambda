variable "aws_region" {
  default = "us-east-1"
}

variable "lambda_bucket_name" {
  default = "lambda-artifacts-fiap-soat"
}

variable "lab_role" {
  default = "LabRole"
}
variable "vpcCidr" {
  default = "172.31.0.0/16"
}