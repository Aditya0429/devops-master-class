provider "aws" {
  region  = "us-east-1"
  version = "~> 2.57"
}

//s3 Bukcet
resource "aws_s3_bucket" "shp_backend_state" {
  bucket = "dev-aplications-backend-state-aabc"
  lifecycle {
    prevent_destroy = true

  }
  versioning {
    enabled = true

  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_dynamodb_table" "shp_backend_lock" {
  name         = "dev_applcation_locsk"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }


}



//Locking Dynamo DB


