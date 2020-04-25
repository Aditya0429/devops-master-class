terraform {
    backend "s3" {
        bucket = "dev-aplications-backend-state-aabc"
        # key = "07-backend-state-users-dev"
        key = "07-backend-state/users/backend-state"
        region = "us-east-1"
        dynamodb_table = "dev_applcation_locsk"
        encrypt = true
    }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.57"
}

resource "aws_iam_user" "my_iam_use" {
  name = "${terraform.workspace}_aditya-iam_user"
}


