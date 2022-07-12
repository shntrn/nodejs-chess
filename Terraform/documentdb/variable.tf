variable "cluster_identifier" {
  type        = string
  default     = "nodejs-docdb-cluster"
  description = "The cluster identifier"
}

variable "engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster"
}

variable "master_username" {
  type        = string
  default     = "nodejsdocdb_user"
  description = "Username for the master DB user"
}

variable "master_password" {
  type        = string
  default     = "aHtku3Fdk30NcyH0IF"
  description = " Password for the master DB user"
}

variable "backup_retention_period" {
  type        = number
  default     = 1
  description = "The days to retain backups for"
}

variable "preferred_backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "The daily time range during which automated backups are created"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
}


variable "docdb_instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = " The instance class to use. Free tier with db.t3.medium"
}

variable "vpc_sg_id" {}
variable "vpc_private_ids" {}
variable "vpc_private_azs" {}

variable "common_tags" {
  type = map(any)
  default = {
    Project = "NodeJS Chess"
    Owner   = "Egor Shantarin"
    Type    = "Database"
  }
}
