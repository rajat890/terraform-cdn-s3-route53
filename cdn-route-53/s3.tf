resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.s3_bucket_name}.${var.fix_domain}"

  tags = {
    Owner       = var.s3_Owner
    Environment = var.s3_environment
    BillingCode = var.s3_billing_code
    Creator     = var.s3_creator
    Name        = var.s3_bucket_name
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }

  #  statement {
  #    actions   = ["s3:ListBucket"]
  #    resources = ["${aws_s3_bucket.s3_bucket.arn}"]
  #
  #    principals {
  #      type        = "AWS"
  #      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
  #    }
  #  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
}

resource "aws_s3_bucket_public_access_block" "s3Public_off" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#locals {
#  s3_origin_id = var.origin_id
#}
