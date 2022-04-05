output "cdn_domain" {
  value = aws_cloudfront_distribution.cdn_test.domain_name
}

output "s3_bucket_name_id" {
  description = "name of s3 bucket creater"
  value       = aws_s3_bucket.s3_bucket.id
}
