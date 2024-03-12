terraform
 provider "aws" {
    region = "ap-south-1" }
 resource"aws_vpc" "main"{
   cidr_block = "10.0.0.0/16" }
 resource "aws_subnet"
"public"{
 vpc_id = aws_vpc.main.id
 cidr_block = "10.0.1.0/24"
 availability_zone ="ap-south-1a"
 }
resource "aws_security_group" "web" {
name = "web_sg"
description = "allow HTTP inbound traffic"
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_block = ["0.0.0./0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_block = ["0.0.0./0"]
}
}
resource "aws_instance" "web"{
ami = 026255a2746f88074
instance_type = "t2.micro"
subnet_id = aws_subnet.public.id
security_group = [aws_security_group.web.name]
}







