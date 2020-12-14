resource "aws_lambda_function" "the_great_bucket_worker" {
  filename      = "../build/function.zip"
  function_name = "the-great-bucket-worker-${terraform.workspace}"
  role          = "arn:aws:iam::${local.account_id}:role/<SOME_SERVICE_ROLE>"

  source_code_hash = filebase64sha256("../build/function.zip")
  handler          = "index.handler"
  runtime          = "nodejs12.x"

  environment {
    variables = {
      ENVIRONMENT = terraform.workspace
    }
  }
}

resource "aws_lambda_permission" "allow_invocation_from_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.the_great_bucket_worker.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.the_great_bucket_watcher.arn
}
