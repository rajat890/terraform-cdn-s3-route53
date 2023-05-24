data "aws_iam_policy_document" "codepipeline_policy_document" {
  statement {
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "AWSCodePipelineFullAccess"
  policy      = data.aws_iam_policy_document.codepipeline_policy_document.json
  description = "Full access policy for AWS CodePipeline"
}

resource "aws_iam_role" "pipeline_role" {
  name               = "infra-pipeline-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "pipeline_policy_attachment" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}

resource "aws_codepipeline" "infra_pipeline" {
  name     = "infra-pipeline-terraform"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = "my-codepipeline-artifacts-terraform"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        RepositoryName = "infra-repo"
        BranchName     = "teraform-test"
      }

      run_order = 1
    }
  }

stage {
  name = "ManualApproval"

  action {
    name            = "ManualApprovalAction"
    category        = "Approval"
    owner           = "AWS"
    provider        = "Manual"
    version         = "1"

    configuration = {
      NotificationArn     = "arn:aws:sns:us-east-1:955813879748:pipeline-approval-terraform"
    }

    run_order = 2
  }
}

  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]

      configuration = {
        ProjectName = "infra-build"
      }

      run_order = 3
    }
  }

}

resource "aws_codebuild_project" "infra_build" {
  name           = "infra-build"
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
      group_name  = "infra-build-logs"
      stream_name = "build-log"
    }
  }

  depends_on = [aws_s3_bucket.codepipeline_artifact_bucket]
}


resource "aws_iam_role" "codebuild_role" {
  name = "infra-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "codebuild_admin_policy" {
  statement {
    actions   = ["codebuild:*"]
    resources = ["*"]
  }

  statement {
    actions   = [
      "s3:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codebuild_admin_policy" {
  name   = "AWSCodeBuildAdminAccess"
  policy = data.aws_iam_policy_document.codebuild_admin_policy.json
}

resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name       = "infra-codebuild-attachment"
  roles      = [aws_iam_role.codebuild_role.name]
  policy_arn = aws_iam_policy.codebuild_admin_policy.arn
}

