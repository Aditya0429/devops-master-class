data "aws_subnet_ids" "default_subnets_test" {
  vpc_id = aws_default_vpc.default.id
}

data "aws_ami" "aws-latest-2-latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

data "aws_ami_ids" "aws_linux_2_latest_ids" {
  owners = ["amazon"]
}