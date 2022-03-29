variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}


variable "Ami_id" {
  default = "ami-00ee4df451840fa9d"


}

variable "instance_type" {
  default = "t2.micro"

}

variable "subnet_cidr" {
  type    = list(any)
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}
variable "availability_zones" {
  type    = list(any)
  default = ["us-west-2a", "us-west-2b"]

}

variable "key_name" {
  default = "samsprojectkp"

}

variable "number_instances" {
  default = "2"

}