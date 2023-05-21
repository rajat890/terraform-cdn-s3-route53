resource "aws_sns_topic" "pipeline_approval_topic" {
  name = "pipeline-approval-terraform"
}

resource "aws_sns_topic_subscription" "approval_email_subscription" {
  topic_arn = aws_sns_topic.pipeline_approval_topic.arn
  protocol  = "email"
  endpoint  = "rajatdhari@gmail.com"
}

