resource "aws_elastic_beanstalk_application" "backend" {
  name        = var.backend_name
  description = "resource for backend"

  tags = merge(var.common_tags, { ServiceType = "BeanstalkApplication" })

}

resource "aws_elastic_beanstalk_environment" "backend_env" {
  name                = var.backend_env_name
  application         = aws_elastic_beanstalk_application.backend.name
  solution_stack_name = "64bit Amazon Linux 2 v5.5.4 running Node.js 14"
  tier                = "WebServer"

  wait_for_ready_timeout = "20m"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_URL"
    value     = "mongodb://${var.db_user}:${var.db_pass}@${var.db_endpoint}:27017/chessMEAN"
  }

  setting {

    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {

    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.vpc_public_ids)

  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }


  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }

  tags = merge(var.common_tags, { ServiceType = "BeanstalkApplication" })

}

