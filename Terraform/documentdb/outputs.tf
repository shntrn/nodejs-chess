output "aws_docdb_cluster" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "aws_docdb_cluster_user" {
  value = aws_docdb_cluster.docdb.master_username
}

output "aws_docdb_cluster_password" {
  value = aws_docdb_cluster.docdb.master_password
}

