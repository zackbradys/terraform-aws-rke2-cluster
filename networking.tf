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

resource "aws_security_group" "aws_rke2_sg" {
  vpc_id      = aws_vpc.aws_rke2_vpc.id
  description = "AWS RKE2 Security Group"
  name        = "${var.prefix}-sg"

  tags = {
    Name = "${var.prefix}-sg"
  }
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow SSH Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress2" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 Agent Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress3" {
  type              = "ingress"
  from_port         = 9345
  to_port           = 9345
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 Server Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress4" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow Ingress Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress5" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow Secure Ingress Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress6" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 Miscellanous Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress7" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 Kubelet Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress8" {
  type              = "ingress"
  from_port         = 2379
  to_port           = 2380
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 ECTD Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress9" {
  type              = "ingress"
  from_port         = 5473
  to_port           = 5473
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 Calico Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress10" {
  type              = "ingress"
  from_port         = 8472
  to_port           = 8472
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow RKE2 VXLAN Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress11" {
  type              = "ingress"
  from_port         = 11443
  to_port           = 11443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow Rancher NeuVector Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress12" {
  type              = "ingress"
  from_port         = 10443
  to_port           = 10443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow Rancher NeuVector Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_egress1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  description       = "Allow All Egress Communication"
}