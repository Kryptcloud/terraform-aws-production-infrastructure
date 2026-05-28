resource "aws_vpc" "aws-vpc-main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}