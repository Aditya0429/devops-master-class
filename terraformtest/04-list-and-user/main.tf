variable "users" {
  default = {
    ravs : { country : "Netherlands", department : "ABC" },
    tom : { country : "US", department : "ABXYZC" },
    jane : { country : "India", department : "ZYX" }
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.57"
}

resource "aws_iam_user" "my_iam_users" {
  for_each = var.users
  name     = each.key
  tags = {
    country : each.value.country
    department : each.value.department
  }
}