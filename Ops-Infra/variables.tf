variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "tf-key2"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type      = string
  sensitive = true
}
