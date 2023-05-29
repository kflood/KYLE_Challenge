provider "aws" {
    region = "us-east-1"
}

variable "home_ip" {
    type = string
}

resource "aws_instance" "web-server" {
    ami = "ami-0715c1897453cabd1"
    instance_type = "t2.micro"
    key_name = "kf_admin"
    vpc_security_group_ids = ["web-server-sg"]

    tags = {
        Name = "web-server"
        Owner = "kf"
    }

}

resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  vpc_id      = "vpc-8892f5f5"

  ingress {
    description      = "allow all traffic from home ip"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.home_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}