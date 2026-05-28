data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = element(var.private_subnet_ids, count.index % length(var.private_subnet_ids))
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name        = "${var.environment}-app-instance-${count.index + 1}"
    Environment = var.environment
  }
}
