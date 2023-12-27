variable "region" {
default = "ap-south-1"
}
variable "vpc_cidr" {
description = "EKS VPC CIDR"
}

variable "private_subnets" {
  description = "EKS Private Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
description = "EKS Public Subnets CIDR"
}

variable "exisitng-vpc-name" {
default     = "Main-VPC"
}