resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/test_lambda_function"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}
