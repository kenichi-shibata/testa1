resource "aws_cloudwatch_event_rule" "the_great_bucket_watcher" {
  name        = "the-great-bucket-watcher-${terraform.workspace}"
  description = "Capture S3 PutObject Events sent from test account"
  event_pattern = templatefile("./templates/cloudwatch.json", {
    data_bucket_name = var.data_bucket_name,
    data_account_id  = var.data_account_id
  })
}

resource "aws_cloudwatch_event_target" "the_great_bucket_watcher" {
  rule = aws_cloudwatch_event_rule.the_great_bucket_watcher.name
  arn  = aws_lambda_function.the_great_bucket_worker.arn
}
