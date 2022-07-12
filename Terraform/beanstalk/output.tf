output "beanstalk_cname" {
  value = aws_elastic_beanstalk_environment.backend_env.cname
}