output "vps_ids" {
  value = module.vpc.aws_vpc_id
}

output "vps_subnets" {
  value = module.vpc.output_vpc_subnet_ids
}

output "cidr_public" {
  value = module.vpc.aws_vpc_public_cidr
}

output "aws_docdb_cluster" {
  value = module.documentdb.aws_docdb_cluster
}

output "beanstalk_endpoint" {
  value = module.beanstalk.beanstalk_cname
}

output "website_endpoint" {
  value = module.staticwebsite.website_endpoint
}