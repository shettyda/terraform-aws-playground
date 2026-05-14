# Account Customisation ( Ribbon Colour)

resource "aws_uxc_account_customizations" "account_ui" {
  account_color = "red"
}



# VPC Creation

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
# Public Subnet Creation

resource "aws_subnet" "pub_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.terra_vpc.id

  tags = {
    Name = "Terra-Subnet-public-"
  }
}

# Private subnet Creation

resource "aws_subnet" "pri_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.terra_vpc.id

  tags = {
    Name = "Terra-subnet-Private"

  }
}

#Public Route Table Creation 

resource "aws_route_table" "pub_terra_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_gw.id

  }

  tags = {
    Name = "Terra-Route-Table-Public"
  }
}


# Private route Table creation

resource "aws_route_table" "priv_terra_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "Terra-Route-Table-Private"
  }
}

# Associate Route Table with Subnet

resource "aws_route_table_association" "rt_ast" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub_terra_rt.id
}

# Associate Route Table with Private Subnet

resource "aws_route_table_association" "pri_rt_ast" {
  subnet_id      = aws_subnet.pri_subnet.id
  route_table_id = aws_route_table.priv_terra_rt.id
}

#creating Elastic IP userd for NAT GATEWAY

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
  