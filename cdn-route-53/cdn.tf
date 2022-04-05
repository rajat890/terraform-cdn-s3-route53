resource "aws_cloudfront_distribution" "cdn_test" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_id   = "${var.s3_bucket_name}.${var.fix_domain}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  #  aliases = ["blog.example.org"]
  aliases = ["${var.s3_bucket_name}.${var.fix_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.s3_bucket_name}.${var.fix_domain}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    compress = true
    #viewer_protocol_policy = "allow-all"
    viewer_protocol_policy = "redirect-to-https"
    #min_ttl                = 0
    #default_ttl            = 3600
    #max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN"]
    }
  }


  price_class = "PriceClass_200"

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:039561965667:certificate/214b1005-dec9-4b95-b870-3f117fd9d2f6"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_caching_min_ttl = "300"
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  tags = {
    Owner       = var.s3_Owner
    Environment = var.s3_environment
    BillingCode = var.s3_billing_code
    Creator     = var.s3_creator
    Name        = var.s3_bucket_name
  }
}
