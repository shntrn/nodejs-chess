output "output_vpc_sg_id" {
  value = aws_security_group.vpc_sg.id
}

output "output_vpc_subnet_ids" {
  value = values(aws_subnet.private)[*].id
}


output "output_vpc_subnet_azs" {
  value = values(aws_subnet.private)[*].availability_zone
}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}

output "aws_vpc_public_id" {
  value = values(aws_subnet.public)[*].id
}

output "aws_vpc_public_cidr" {
  value = values(aws_subnet.public)[*].cidr_block
}


