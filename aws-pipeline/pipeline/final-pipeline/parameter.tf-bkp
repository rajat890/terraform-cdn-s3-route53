resource "aws_ssm_parameter" "destroy_infra_parameter" {
  name        = var.destroy_infra_parameter_name
  description = "Parameter for destroying infrastructure in CodeBuild"
  type        = "String"
  value       = "false"
  tier        = "Standard"
}
