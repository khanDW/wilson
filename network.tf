resource "aws_vpc" "sam1_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sam1_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "samsRT" {
  vpc_id = aws_vpc.sam1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "samsRT"
  }
}
resource "aws_route_table_association" "pubRTassoc" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.pubsubnets.*.id, count.index)
  route_table_id = aws_route_table.samsRT.id
}

resource "aws_subnet" "pubsubnets" {
  count             = length(var.subnet_cidr)
  vpc_id            = aws_vpc.sam1_vpc.id
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "subnet-${count.index +1}"
  }
}