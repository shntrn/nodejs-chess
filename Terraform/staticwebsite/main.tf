resource "aws_s3_bucket" "static" {
  bucket = var.bucket_name

  policy = templatefile("./templates/s3-policy.json", { bucket = "${var.bucket_name}" })

  tags = merge(var.common_tags, { ServiceType = "S3" })

}

resource "aws_s3_bucket_acl" "static_acl" {
  bucket = aws_s3_bucket.static.id
  acl    = "public-read"

}



resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.static.bucket

  index_document {
    suffix = "index.html"
  }
}

