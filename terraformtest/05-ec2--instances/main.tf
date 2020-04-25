variable "aws_key_pair" {
  default = "/home/aditya6/aditya6.pem"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.57"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#data "aws_ami" "aws-latest-2-latest" {
#  most_recent = true
#  owners      = ["amazon"]
#  filter {
#    name   = "name"
#    values = ["amin2-ami-hvm-*"]
#  }

# }

data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id

}



resource "aws_security_group" "my_first_security_group" {
  name = "Demiliterzed_SG"

  //vpc_id = "vpc-924b8ee8"
  vpc_id = aws_default_vpc.default.id



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    name = "Http_Server_SG_TEST"
  }
}

resource "aws_instance" "http_instance" {
  ami                    = "ami-0323c3dd2da7fb37d"
  key_name               = "aditya6"
  instance_type          = "t2.small"
  vpc_security_group_ids = [aws_security_group.my_first_security_group.id]
  //subnet_id              = "subnet-217acc7d"
  subnet_id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                //install httpd
      "sudo service httpd start",                                                                                 //start the server
      "echo Welcone to in28 min - virtual server is ${self.public_dns} World | sudo tee /var/www/html/index.html" //copy a file

    ]
  }

}


