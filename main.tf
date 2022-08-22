provider "aws" {
  region     = "eu-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "larry_vpc" {   //define a VPC first and give it a CIDR block
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "larry-vpc"
    }
}

resource "aws_internet_gateway" "larry_ig" {   //give the VPC access to internet
    vpc_id = aws_vpc.larry_vpc.id

    tags = {
        Name = "larry-ig"
    }
}

resource "aws_route_table" "larry_rt" {  //should connect to the internet gateway
    vpc_id = aws_vpc.larry_vpc.id
    route {
        cidr_block = "0.0.0.0/0"     //same ip like the VPC
        gateway_id = aws_internet_gateway.larry_ig.id
    }
}

resource "aws_subnet" "larry_subnet" {
    vpc_id = aws_vpc.larry_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-2a"
    map_public_ip_on_launch = true
}

resource "aws_route_table_association" "larry_rta" {   //links route table to subnet
    subnet_id = aws_subnet.larry_subnet.id
    route_table_id = aws_route_table.larry_rt.id
}

resource "aws_security_group" "sgApp2" { // in the application layer
  name        = "sgApp2"
  description = "allow SSH and HTTP access"
  vpc_id      = aws_vpc.larry_vpc.id      // previous value aws_vpc.DemoVPC.id

  ingress { 
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
    description = "jenkins access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
        to_port = 0
        from_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "jenkins-server" {
  ami                         = "ami-0015a39e4b7c0966f"
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key
  subnet_id                   =  aws_subnet.larry_subnet.id //related to the vpc   
  vpc_security_group_ids       = [aws_security_group.sgApp2.id]   //reference it to the security group below
  associate_public_ip_address = true       

  tags = {
    Name = "${var.name}.tf.jenkins-server"
  }

  user_data = "${file("script.sh")}"
}

resource "aws_instance" "ansible-machine" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key
  subnet_id                   =  aws_subnet.larry_subnet.id //related to the vpc   
  vpc_security_group_ids       = [aws_security_group.sgApp2.id]   //reference it to the security group below
  associate_public_ip_address = true       

  tags = {
    Name = "${var.name}.tf.ansible-machine"
  }

  user_data = "${file("script.sh")}"
}