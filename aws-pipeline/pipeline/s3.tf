resource "aws_s3_bucket" "codepipeline_artifact_bucket" {
  bucket = "my-codepipeline-artifacts-terraform"
}

