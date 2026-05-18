# Private subnet Creation

resource "aws_subnet" "pri_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.terra_vpc.id

  tags = {
    Name = "Terra-subnet-Private"

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
