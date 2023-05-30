resource "aws_codepipeline" "infra_pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = "terraform-pipeline-bucket-final"
    type     = "S3"
  }

  stage {
    name = var.source_stage_name

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = [var.source_output_artifact]

      configuration = {
        RepositoryName = var.repository_name
        BranchName     = var.branch_name
      }

      run_order = 1
    }
  }

  stage {
    name = var.build_stage_name

    action {
      name             = var.build_action_name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = [var.build_output_artifact]

      configuration = {
        ProjectName = var.tfsec_build_name
      }

      run_order = 2
    }
  }

  stage {
    name = var.approval_stage_name

    action {
      name     = var.approval_action_name
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

     # configuration = {
     #   NotificationArn = var.notification_arn
    # } 

      run_order = 3
    }
  }

  stage {
    name = var.infra_build_stage_name

    action {
      name             = var.infra_build_action_name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = [var.infra_build_output_artifact]

      configuration = {
        ProjectName = var.infra_build_name
      }

      run_order = 4
    }
  }

  stage {
    name = var.destroy_build_stage_name

    action {
      name             = var.destroy_build_action_name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = [var.destroy_build_output_artifact]

      configuration = {
        ProjectName = var.destroy_build_name
      }

      run_order = 5
    }
  }
}
