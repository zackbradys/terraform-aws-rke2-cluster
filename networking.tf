resource "aws_vpc" "aws_rke2_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_eip" "aws_rke2_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.aws_rke2_igw]

  tags = {
    Name = "${var.prefix}-eip"
  }
}

resource "aws_nat_gateway" "aws_rke2_ngw" {
  allocation_id = aws_eip.aws_rke2_eip.id
  subnet_id     = aws_subnet.aws_rke2_public_subnet1.id
  depends_on    = [aws_internet_gateway.aws_rke2_igw]

  tags = {
    Name = "${var.prefix}-ngw"
  }
}

resource "aws_route_table" "aws_rke2_private_rtb" {
  vpc_id     = aws_vpc.aws_rke2_vpc.id
  depends_on = [aws_vpc.aws_rke2_vpc]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_rke2_ngw.id
  }

  tags = {
    Name = "${var.prefix}-private-rtb"
  }
}

resource "aws_subnet" "aws_rke2_private_subnet1" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = "${var.region}a"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-private-subnet1"
  }
}

resource "aws_subnet" "aws_rke2_private_subnet2" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = "${var.region}b"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-private-subnet2"
  }
}

resource "aws_subnet" "aws_rke2_private_subnet3" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[2]
  availability_zone = "${var.region}c"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-private-subnet3"
  }
}

resource "aws_route_table_association" "aws_rke2_private_rta1" {
  subnet_id      = aws_subnet.aws_rke2_private_subnet1.id
  route_table_id = aws_route_table.aws_rke2_private_rtb.id
  depends_on     = [aws_route_table.aws_rke2_private_rtb]
}

resource "aws_route_table_association" "aws_rke2_private_rta2" {
  subnet_id      = aws_subnet.aws_rke2_private_subnet2.id
  route_table_id = aws_route_table.aws_rke2_private_rtb.id
  depends_on     = [aws_route_table.aws_rke2_private_rtb]
}

resource "aws_route_table_association" "aws_rke2_private_rta3" {
  subnet_id      = aws_subnet.aws_rke2_private_subnet3.id
  route_table_id = aws_route_table.aws_rke2_private_rtb.id
  depends_on     = [aws_route_table.aws_rke2_private_rtb]
}

resource "aws_internet_gateway" "aws_rke2_igw" {
  vpc_id     = aws_vpc.aws_rke2_vpc.id
  depends_on = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "aws_rke2_public_rtb" {
  vpc_id     = aws_vpc.aws_rke2_vpc.id
  depends_on = [aws_vpc.aws_rke2_vpc]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_rke2_igw.id
  }

  tags = {
    Name = "${var.prefix}-public-rtb"
  }
}

resource "aws_subnet" "aws_rke2_public_subnet1" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[0]
  availability_zone = "${var.region}a"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-public-subnet1"
  }
}

resource "aws_subnet" "aws_rke2_public_subnet2" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[1]
  availability_zone = "${var.region}b"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-public-subnet2"
  }
}

resource "aws_subnet" "aws_rke2_public_subnet3" {
  vpc_id            = aws_vpc.aws_rke2_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[2]
  availability_zone = "${var.region}c"
  depends_on        = [aws_vpc.aws_rke2_vpc]

  tags = {
    Name = "${var.prefix}-public-subnet3"
  }
}

resource "aws_route_table_association" "aws_rke2_public_rta1" {
  subnet_id      = aws_subnet.aws_rke2_public_subnet1.id
  route_table_id = aws_route_table.aws_rke2_public_rtb.id
  depends_on     = [aws_route_table.aws_rke2_public_rtb]
}

resource "aws_route_table_association" "aws_rke2_public_rta2" {
  subnet_id      = aws_subnet.aws_rke2_public_subnet2.id
  route_table_id = aws_route_table.aws_rke2_public_rtb.id
  depends_on     = [aws_route_table.aws_rke2_public_rtb]
}

resource "aws_route_table_association" "aws_rke2_public_rta3" {
  subnet_id      = aws_subnet.aws_rke2_public_subnet3.id
  route_table_id = aws_route_table.aws_rke2_public_rtb.id
  depends_on     = [aws_route_table.aws_rke2_public_rtb]
}