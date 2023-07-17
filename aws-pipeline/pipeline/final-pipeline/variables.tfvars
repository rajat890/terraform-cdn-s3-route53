codebuild_role_name = "terraform-codebuild-role"
pipeline_role_name = "terraform-pipeline-role"
tfsec_build_name = "tfsec-build"
infra_build_name = "infra-build"
destroy_build_name = "destroy-build"
repository_name = "vpc-repo"
branch_name = "master"
pipeline_name = "terraform-pipeline"
approval_stage_name = "manual-approval"
source_stage_name = "codecommit-connection"
#notification_arn = "arn:aws:sns:us-east-1:226479769484:pipeline-approval"  ## add this value only if need to enable email approval
#destroy_infra_parameter_name = "/CodeBuild/DESTROY_INFRA"  ## we will keep this value same 

