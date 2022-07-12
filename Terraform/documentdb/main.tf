module "vpc" {
  source = "./../vpc"
}

resource "aws_docdb_subnet_group" "service" {
  name       = "docdb_subnet-${var.cluster_identifier}"
  subnet_ids = var.vpc_private_ids

  tags = merge(var.common_tags, { ServiceType = "DocDBSubnetGroup" })

}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = var.cluster_identifier
  db_subnet_group_name            = aws_docdb_subnet_group.service.name
  engine                          = var.engine
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  vpc_security_group_ids          = [var.vpc_sg_id]
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.service.name

  tags = merge(var.common_tags, { ServiceType = "DocDBCluster" })


}

resource "aws_docdb_cluster_instance" "docdb" {
  count              = 1
  identifier         = "tf-${var.cluster_identifier}-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.docdb_instance_class

  tags = merge(var.common_tags, { ServiceType = "DocDBClusterInstance" })
}

resource "aws_docdb_cluster_parameter_group" "service" {
  family = "docdb4.0"
  name   = var.cluster_identifier

  parameter {
    name  = "tls"
    value = "disabled"
  }

  tags = merge(var.common_tags, { ServiceType = "DocDBClusterParameter" })

}