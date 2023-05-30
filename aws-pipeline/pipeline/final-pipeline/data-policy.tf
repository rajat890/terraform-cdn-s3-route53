#this is the block for codepipeline iam policy

data "aws_iam_policy_document" "codepipeline_policy_document" {
  statement {
    actions = [
      "ec2:*",
      "sns:*",
      "codecommit:*",
      "s3:*",
      "codebuild:*",
      "codedeploy:*",
      "ssm:*",
      "logs:*",
      "iam:*"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_policy" "codepipeline_policy" {
  name        = var.codepipeline_policy_name
  policy      = data.aws_iam_policy_document.codepipeline_policy_document.json
  description = "Full access policy for AWS CodePipeline"
}

resource "aws_iam_role" "pipeline_role" {
  name               = var.pipeline_role_name
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

########################################
##Below is the block for codebuild role and policy######

resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name

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
    actions = [
      "codebuild:*",
      "ec2:*",
      "ssm:GetParameter*",
      "ssm:GetParameters*",
      "ssm:GetParameterHistory*",
      "ssm:DescribeParameters",
      "sns:*",
      "s3:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeVpcs",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DescribeSubnets",
      "ssm:*"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_policy" "codebuild_admin_policy" {
  name   = var.codebuild_admin_policy_name
  policy = data.aws_iam_policy_document.codebuild_admin_policy.json
}

resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name       = "infra-codebuild-attachment"
  roles      = [aws_iam_role.codebuild_role.name]
  policy_arn = aws_iam_policy.codebuild_admin_policy.arn
}

