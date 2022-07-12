#S3 bucket module for static website
module "staticwebsite" {
  source      = "./staticwebsite"
  bucket_name = var.s3_bucket_name

}

#VPC module
module "vpc" {
  source = "./vpc"
}

#DocumentDB module for DB
module "documentdb" {
  source          = "./documentdb"
  depends_on      = [module.vpc]
  vpc_sg_id       = module.vpc.output_vpc_sg_id
  vpc_private_ids = module.vpc.output_vpc_subnet_ids
  vpc_private_azs = module.vpc.output_vpc_subnet_azs
}

#Beanstalk module for backend
module "beanstalk" {
  source           = "./beanstalk"
  backend_name     = var.backend_name
  backend_env_name = var.backend_env_name
  depends_on       = [module.documentdb, module.vpc]
  db_endpoint      = module.documentdb.aws_docdb_cluster
  db_user          = module.documentdb.aws_docdb_cluster_user
  db_pass          = module.documentdb.aws_docdb_cluster_password
  vpc_id           = module.vpc.aws_vpc_id
  vpc_public_ids   = module.vpc.aws_vpc_public_id
}