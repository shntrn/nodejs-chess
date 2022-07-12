output "srorage_arn" {
  value = aws_s3_bucket.static.arn
}

output "website_domain" {
  value = aws_s3_bucket_website_configuration.static.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.static.website_endpoint
}