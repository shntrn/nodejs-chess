#Variable for s3 (static webstie)
variable "s3_bucket_name" {
  description = "name of s3 bucket website"
}

#Variable for beanstalk (backend)
variable "backend_name" {
  description = "name of beanstalk application "

}
variable "backend_env_name" {
  description = "name of beanstalk application environment"
}