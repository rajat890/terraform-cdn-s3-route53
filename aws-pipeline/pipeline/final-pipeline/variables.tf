### variables for the codepipeline and codebuild role policy

variable "codebuild_role_name" {
  description = "Name of the AWS CodeBuild role"
  default     = "terraform-codebuild-role"
}

variable "pipeline_role_name" {
  description = "Name of the AWS CodePipeline role"
  default     = "terraform-pipeline-role"
}

variable "source_output_artifact" {
  type        = string
  description = "Name of the output artifact from the Source stage"
  default     = "SourceOutput"
}

###################
###Variable for codebuild project########

variable "tfsec_build_name" {
  description = "Name of the tfsec-build project"
  type        = string
  default     = "tfsec-build"
}


variable "infra_build_name" {
  description = "Name of the infra-build project"
  type        = string
  default     = "infra-build"
}


variable "destroy_build_name" {
  description = "Name of the destroy build phase"
  type        = string
  default     = "destroy-build"
}


########################################################
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
  description = "giving the pipeline name"
  default     = "terraform-pipeline"
}


variable "approval_stage_name" {
  type        = string
  description = "approval stage"
  default     = "manual-approval"
}

variable "source_stage_name" {
  type        = string
  description = "stage with codecommit "
  default     = "codecommit-connection"
}

variable "notification_arn" {
  type        = string
  description = "ARN of the SNS topic for manual approval notifications"
  default     = "arn:aws:sns:us-east-1:226479769484:pipeline-approval"
}

variable "destroy_infra_parameter_name" {
  description = "Name of the SSM parameter for destroying infrastructure in CodeBuild"
  default     = "/CodeBuild/DESTROY_INFRA"
}

