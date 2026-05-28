variable "aws_region" {
  type = string
  default = "eu-north-1"
}


variable "vpc_cidr" {
    type       = string
    description = "CIDR block for the VPC"
}

variable "vpc_name" {
    type       = string
    description = "Name tag for the VPC"
}

# variable "vpc_cidr" {
#   type = string
#   default = "10.0.0.0/16"
# }

# variable "vpc_name" {
#   type = string
#   default = "aws-vpc-main"
# }