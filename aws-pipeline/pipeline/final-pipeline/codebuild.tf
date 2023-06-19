resource "aws_codebuild_project" "tfsec_build" {
  name           = var.tfsec_build_name
  description    = "tfsec scan for infrastructure build"
  service_role   = aws_iam_role.codebuild_role.arn
  build_timeout  = 60
  queued_timeout = 480

  source {
    type                = "CODEPIPELINE"
    buildspec           = "tfsec-buidspec.yml"
    report_build_status = true
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "${var.tfsec_build_name}-log-group"
      stream_name = "${var.tfsec_build_name}-stream"
    }
  }
}

resource "aws_codebuild_project" "infra_build" {
  name           = var.infra_build_name
  description    = "CodeBuild project for infrastructure build"
  service_role   = aws_iam_role.codebuild_role.arn
  build_timeout  = 60
  queued_timeout = 480

  source {
    type                = "CODEPIPELINE"
    buildspec           = "terraform-buidspec.yml"
    report_build_status = true
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "${var.infra_build_name}-log-group"
      stream_name = "${var.infra_build_name}-stream"
    }
  }
}

resource "aws_codebuild_project" "destroy_build" {
  name           = var.destroy_build_name
  description    = "CodeBuild project for destroy check"
  service_role   = aws_iam_role.codebuild_role.arn
  build_timeout  = 60
  queued_timeout = 480

  source {
    type                = "CODEPIPELINE"
    buildspec           = "destroy-buidspec.yml"
    report_build_status = true
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "${var.destroy_build_name}-log-group"
      stream_name = "${var.destroy_build_name}-stream"
    }
  }
}
