resource "aws_iam_role" "lambda_role" {
  name               = "lambda-${var.app_name}"
  assume_role_policy = "${data.aws_iam_policy_document.trust_policy.json}"
}

# trust policy
data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda.zip"
  function_name    = "lambda_function_name"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "exports.test"
  source_code_hash = "${base64sha256(file("../build/lambda.zip"))}"
  runtime          = "nodejs8.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
