variable "net_name" {
  type    = string
  default = "nodejs-chess"

}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The IP range to use for the VPC"
}

variable "private_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for private subnets"


  default = {
    "eu-central-1a" = 1
    "eu-central-1b" = 2
  }
}

variable "public_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for public subnets"

  default = {
    "eu-central-1a" = 4
    "eu-central-1b" = 5
  }
}

variable "db_port" {
  type        = number
  default     = 27017
  description = "Port of DocumentDB for security group"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project = "NodeJS Chess"
    Owner   = "Egor Shantarin"
    Type    = "Network"
  }
}