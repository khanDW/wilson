output "ip" {
    value = "${join(",", aws_instance.ec2-pub.*.public_ip)}"
}