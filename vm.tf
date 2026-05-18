# Account Customisation ( Ribbon Colour)

resource "aws_uxc_account_customizations" "account_ui" {
  account_color = "red"
}

#VPC Creation

resource "aws_vpc" "terra_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terra-created-VPC"
  }
}

# Internet Gateway creation

resource "aws_internet_gateway" "terra_gw" {
  vpc_id = aws_vpc.terra_vpc.id #interpolation

  tags = {
    Name = "Terra-Gateway"
  }
}

#creating Elastic IP used for NAT GATEWAY

resource "aws_eip" "eip" {
  domain = "vpc"
}

#Creating NAT Table

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_subnet.id

  tags = {
    Name = "Terra-Created-nat_gw"
  }
}

#Creating Public EC2 Instance

resource "aws_instance" "pub_ec2" {
  subnet_id = aws_subnet.pub_subnet.id

  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t3.micro"

  tags = {
    Name = "public_ec2_Instance"
  }
}

#Creating Private instance

resource "aws_instance" "pri_ec2" {
  subnet_id = aws_subnet.pri_subnet.id

  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t3.micro"

  tags = {
    Name = "Private_ec2_Instance"
  }
}
  