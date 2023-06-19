resource "aws_s3_bucket" "s3_bucket" {
  bucket = "jellyfishbucket"

}

resource "aws_s3_bucket_public_access_block" "s3Public_off" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

