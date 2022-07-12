variable "backend_name" {
  type        = string
  description = "name for beanstalk"
}

variable "backend_env_name" {
  type        = string
  description = "name for beanstalk"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project = "NodeJS Chess"
    Owner   = "Egor Shantarin"
    Type    = "BackEnd"
  }
}

variable "db_endpoint" {}
variable "db_user" {}
variable "db_pass" {}

variable "vpc_id" {}

variable "vpc_public_ids" {}

