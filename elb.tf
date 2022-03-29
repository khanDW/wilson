
resource "aws_lb_target_group" "ec2group" {
  name     = "ec2group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sam1_vpc.id

}
resource "aws_lb_target_group_attachment" "ec2att" {
  count = length(aws_instance.ec2-pub)
  target_group_arn = aws_lb_target_group.ec2group.arn
  target_id        = aws_instance.ec2-pub[count.index].id
  port             = 80
}

resource "aws_elb" "sams-elb" {
  name               = "sams-elb"
  availability_zones = var.availability_zones
  subnets    = aws_subnet.pubsubnets.*.id
  security_groups = ["${aws_security_group.allow_web.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = aws_instance.ec2-pub.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "elb"
  }
}
