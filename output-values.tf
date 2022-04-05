output "s3_bucket_arn" {
  description = "name of s3 bucket creater"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_name" {
  description = "name of s3 bucket creater"
  value       = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

output "s3_bucket_name_id" {
  description = "name of s3 bucket creater"
  value       = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_name_test" {
  description = "name of s3 bucket creater"
  value       = aws_s3_bucket.s3_bucket.bucket_domain_name
}
