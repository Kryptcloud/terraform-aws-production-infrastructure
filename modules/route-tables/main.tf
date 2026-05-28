
# 1. PUBLIC ROUTING (Traffic goes to Internet Gateway)
# ==============================================================================

# Create Route Tables for Public Subnets
resource "aws_route_table" "public" {
  count  = length(var.public_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name        = "${var.environment}-public-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Associate Public Route Tables with Public Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public[count.index].id
}


# ==============================================================================
# 2. PRIVATE ROUTING (Traffic goes to Multi-AZ NAT Gateways)
# ==============================================================================

# Create Route Tables for Private Subnets (1 per AZ)
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_ids[count.index] # Maps AZ1 to NAT1, AZ2 to NAT2
  }

  tags = {
    Name        = "${var.environment}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Associate Private Route Tables with Private Subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
