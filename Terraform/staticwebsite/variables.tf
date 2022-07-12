variable "bucket_name" {
  type        = string
  description = "bucket name for static website"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project = "NodeJS Chess"
    Owner   = "Egor Shantarin"
    Type    = "FrontEnd"
  }
}