### variables for the codepipeline and codebuild role policy

variable "codepipeline_policy_name" {
  description = "Name of the AWS CodePipeline policy"
  default     = "terraform-pipeline-policy"
}

variable "codebuild_admin_policy_name" {
  description = "Name of the AWS CodeBuild admin policy"
  default     = "terraform-build-policy"
}

variable "codebuild_role_name" {
  description = "Name of the AWS CodeBuild role"
  default     = "terraform-codebuild-role"
}

variable "pipeline_role_name" {
  description = "Name of the AWS CodePipeline role"
  default     = "terraform-pipeline-role"
}


###################
###Variable for codebuild project########

variable "tfsec_build_name" {
  description = "Name of the tfsec-build project"
  type        = string
  default     = "tfsec-build"
}

variable "tfsec_build_group_name" {
  description = "Name of the CloudWatch Logs group for tfsec-build"
  type        = string
  default     = "tfsec-build-logs"
}

variable "tfsec_build_stream_name" {
  description = "Name of the CloudWatch Logs stream for tfsec-build"
  type        = string
  default     = "tfsec-log"
}

variable "infra_build_name" {
  description = "Name of the infra-build project"
  type        = string
  default     = "infra-build"
}

variable "infra_build_group_name" {
  description = "Name of the CloudWatch Logs group for infra-build"
  type        = string
  default     = "infra-build-logs"
}

variable "infra_build_stream_name" {
  description = "Name of the CloudWatch Logs stream for infra-build"
  type        = string
  default     = "build-log"
}

variable "destroy_build_name" {
  description = "Name of the destroy build phase"
  type        = string
  default     = "destroy-build"
}


variable "destroy_build_group_name" {
  description = "Name of the CloudWatch Logs group for destroy-build"
  type        = string
  default     = "destroy-build-logs"
}

variable "destroy_build_stream_name" {
  description = "Name of the CloudWatch Logs stream for destroy-build"
  type        = string
  default     = "destroy-log"
}

######################variables for branch and repo######
variable "repository_name" {
  type        = string
  description = "Name of the CodeCommit repository"
  default     = "vpc-repo"
}

variable "branch_name" {
  type        = string
  description = "Name of the branch to use for the Source stage"
  default     = "master"
}

##########variables for pipeline and codebuild###########

variable "pipeline_name" {
  type        = string
  description = "Name of the AWS CodePipeline"
  default     = "infra-pipeline-terraform"
}

variable "source_stage_name" {
  type        = string
  description = "Name of the Source stage"
  default     = "Source"
}


variable "source_output_artifact" {
  type        = string
  description = "Name of the output artifact from the Source stage"
  default     = "SourceOutput"
}

variable "build_stage_name" {
  type        = string
  description = "Name of the Build stage"
  default     = "Build"
}

variable "build_action_name" {
  type        = string
  description = "Name of the Build action"
  default     = "tfsecbuild"
}

variable "build_output_artifact" {
  type        = string
  description = "Name of the output artifact from the Build stage"
  default     = "BuildOutput"
}

variable "approval_stage_name" {
  type        = string
  description = "Name of the Manual Approval stage"
  default     = "ManualApproval"
}

variable "approval_action_name" {
  type        = string
  description = "Name of the Manual Approval action"
  default     = "ManualApprovalAction"
}

variable "notification_arn" {
  type        = string
  description = "ARN of the SNS topic for manual approval notifications"
  default     = "arn:aws:sns:us-east-1:226479769484:pipeline-approval"
}

variable "infra_build_stage_name" {
  type        = string
  description = "Name of the InfraBuild stage"
  default     = "InfraBuild"
}

variable "infra_build_action_name" {
  type        = string
  description = "Name of the InfraBuild action"
  default     = "InfraBuildAction"
}

variable "infra_build_output_artifact" {
  type        = string
  description = "Name of the output artifact from the InfraBuild stage"
  default     = "InfraBuildOutput"
}

variable "destroy_build_stage_name" {
  type        = string
  description = "Name of the destroy  stage"
  default     = "destroyBuild"
}

variable "destroy_build_action_name" {
  type        = string
  description = "Name of the destroy action"
  default     = "Destroyaction"
}

variable "destroy_build_output_artifact" {
  type        = string
  description = "Name of the output artifact from the destroy stage"
  default     = "destroyBuildOutput"
}

