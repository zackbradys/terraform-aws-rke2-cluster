resource "aws_elb" "aws_rke2_lb" {
  connection_draining         = false
  connection_draining_timeout = 300
  cross_zone_load_balancing   = true
  desync_mitigation_mode      = "defensive"
  idle_timeout                = 60
  internal                    = false
  name                        = "${var.prefix}-k8s-lb"
  security_groups             = [aws_security_group.aws_rke2_sg.id]
  subnets                     = [aws_subnet.aws_rke2_public_subnet1.id, aws_subnet.aws_rke2_public_subnet2.id, aws_subnet.aws_rke2_public_subnet3.id]
  depends_on                  = [aws_instance.aws_ec2_instance_control, aws_instance.aws_ec2_instance_controls]

  health_check {
    healthy_threshold   = 3
    interval            = 30
    target              = "TCP:6443"
    timeout             = 5
    unhealthy_threshold = 5
  }

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 9345
    instance_protocol = "tcp"
    lb_port           = 9345
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }
}

resource "aws_elb_attachment" "aws_rke2_elb_attachment1" {
  elb        = aws_elb.aws_rke2_lb.id
  count      = var.number_of_instances_control
  instance   = aws_instance.aws_ec2_instance_control[count.index].id
  depends_on = [aws_elb.aws_rke2_lb]
}

resource "aws_elb_attachment" "aws_rke2_elb_attachment2" {
  elb        = aws_elb.aws_rke2_lb.id
  count      = var.number_of_instances_controls
  instance   = aws_instance.aws_ec2_instance_controls[count.index].id
  depends_on = [aws_elb.aws_rke2_lb]
}

resource "aws_elb" "aws_rke2_ingress_lb" {
  connection_draining         = false
  connection_draining_timeout = 300
  cross_zone_load_balancing   = true
  desync_mitigation_mode      = "defensive"
  idle_timeout                = 60
  internal                    = false
  name                        = "${var.prefix}-ingress-lb"
  security_groups             = [aws_security_group.aws_rke2_sg.id]
  subnets                     = [aws_subnet.aws_rke2_public_subnet1.id, aws_subnet.aws_rke2_public_subnet2.id, aws_subnet.aws_rke2_public_subnet3.id]
  depends_on                  = [aws_instance.aws_ec2_instance_control, aws_instance.aws_ec2_instance_controls, aws_instance.aws_ec2_instance_worker]

  health_check {
    healthy_threshold   = 3
    interval            = 30
    target              = "TCP:80"
    timeout             = 5
    unhealthy_threshold = 5
  }

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }
}

resource "aws_elb_attachment" "aws_rke2_elb_attachment3" {
  elb        = aws_elb.aws_rke2_ingress_lb.id
  count      = var.number_of_instances_control
  instance   = aws_instance.aws_ec2_instance_control[count.index].id
  depends_on = [aws_elb.aws_rke2_ingress_lb]
}

resource "aws_elb_attachment" "aws_rke2_elb_attachment4" {
  elb        = aws_elb.aws_rke2_ingress_lb.id
  count      = var.number_of_instances_controls
  instance   = aws_instance.aws_ec2_instance_controls[count.index].id
  depends_on = [aws_elb.aws_rke2_ingress_lb]
}

resource "aws_elb_attachment" "aws_rke2_elb_attachment5" {
  elb        = aws_elb.aws_rke2_ingress_lb.id
  count      = var.number_of_instances_worker
  instance   = aws_instance.aws_ec2_instance_worker[count.index].id
  depends_on = [aws_elb.aws_rke2_ingress_lb]
}