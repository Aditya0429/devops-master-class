variable "environment" {
  default = "dev"
}

variable "my_iam_user_prefix" {
  type    = string
  default = "my_iam_user"
}


provider "aws" {
  region  = "us-east-1"
  version = "~> 2.57"
}

resource "aws_iam_user" "iam_user_creation" {
  count = 1
  name  = "${var.environment}_${var.my_iam_user_prefix}_${count.index}" 
}
