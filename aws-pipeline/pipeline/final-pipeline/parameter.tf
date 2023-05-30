resource "aws_ssm_parameter" "destroy_infra_parameter" {
  name        = "/CodeBuild/DESTROY_INFRA"
  description = "Parameter for destroying infrastructure in CodeBuild"
  type        = "String"
  value       = "false"
  tier        = "Standard"
}
