resource "aws_instance" "ec2-pub" {
  count           = var.number_instances
  ami             = var.Ami_id
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.allow_web.id}"]
  subnet_id       = element(aws_subnet.pubsubnets.*.id, count.index)
  key_name        = var.key_name
  associate_public_ip_address = "true" 

  user_data = <<-EOF
           #!/bin/bash
           sudo apt update -y
           sudo apt install apache2 -y
           sudo systemctl start apache2
           sudo bash -c 'echo your very first web server > /var/www/html/index.html
           EOF

  tags = {
    Name = "weberver-${count.index}"
  }
}