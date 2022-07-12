resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.common_tags, { ServiceType = "VPC" })

}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers
  vpc_id   = aws_vpc.main.id

  availability_zone = each.key

  # 254 hosts each
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value)

  tags = {
    Subnet = "${each.key}-${each.value}"
  }

}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  # 254 hosts each
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value)


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table_association" "public" {
  count          = length(values(aws_subnet.public)[*].cidr_block)
  subnet_id      = element(values(aws_subnet.public)[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}



#Security group for DocumentDB cluster
resource "aws_security_group" "vpc_sg" {
  name   = "vpc-${var.net_name}"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



