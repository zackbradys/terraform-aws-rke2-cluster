resource "aws_security_group" "aws_rke2_sg" {
  vpc_id      = aws_vpc.aws_rke2_vpc.id
  depends_on  = [aws_vpc.aws_rke2_vpc]
  description = "AWS RKE2 Security Group"
  name        = "${var.prefix}-sg"

  tags = {
    Name = "${var.prefix}-sg"
  }
}

#resource "aws_security_group_rule" "aws_rke2_sg_ingress" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.aws_rke2_sg.id
#  depends_on        = [aws_security_group.aws_rke2_sg]
#  description       = "Allow All Communication"
#}

resource "aws_security_group_rule" "aws_rke2_sg_ingress1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow SSH Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Ingress Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress3" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Secure Ingress Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress4" {
  type              = "ingress"
  from_port         = 2376
  to_port           = 2376
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Rancher Provisioning Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress5" {
  type              = "ingress"
  from_port         = 2379
  to_port           = 2380
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 ECTD Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress6" {
  type              = "ingress"
  from_port         = 4789
  to_port           = 4789
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Calico Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress7" {
  type              = "ingress"
  from_port         = 5473
  to_port           = 5473
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Calico Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress8" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Agent Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress9" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Validation Ingress Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress10" {
  type              = "ingress"
  from_port         = 8472
  to_port           = 8472
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 VXLAN Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress11" {
  type              = "ingress"
  from_port         = 9345
  to_port           = 9345
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Server Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress12" {
  type              = "ingress"
  from_port         = 9796
  to_port           = 9796
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Rancher Monitoring Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress13" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10252
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Kubelet Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress14" {
  type              = "ingress"
  from_port         = 10256
  to_port           = 10256
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 KubeProxy Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress15" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Miscellanous Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress16" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow RKE2 Miscellanous Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress17" {
  type              = "ingress"
  from_port         = 10443
  to_port           = 10443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Rancher NeuVector Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_ingress18" {
  type              = "ingress"
  from_port         = 11443
  to_port           = 11443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow Rancher NeuVector Communication"
}

resource "aws_security_group_rule" "aws_rke2_sg_egress1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.aws_rke2_sg.id
  depends_on        = [aws_security_group.aws_rke2_sg]
  description       = "Allow All Egress Communication"
}