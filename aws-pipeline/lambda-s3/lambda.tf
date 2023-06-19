###lambda function code

data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "lambda_function.py" 
  output_path = "nametest.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "nametest.zip"
  function_name    = "test_lambda_function"
  source_code_hash = "${data.archive_file.python_lambda_package.output_base64sha256}"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
}

######s3 trigger#####

resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.s3_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:Put", "s3:ObjectRemoved:*"]
    filter_prefix = "test"
  }
}
resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = "test_lambda_function"
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}"
}

####iam policy############

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    actions = [
      "s3:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"

    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-access-policy"
  policy      = data.aws_iam_policy_document.lambda_policy_document.json
  description = "Full access lambda"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda_tf.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
