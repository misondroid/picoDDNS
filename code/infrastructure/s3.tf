data "aws_s3_bucket" "management_bucket" {
  bucket = var.management_bucket
}

resource "aws_s3_bucket_notification" "management_bucket_notification" {
  bucket = data.aws_s3_bucket.management_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.app.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "app/${var.app_env}/"
    filter_suffix       = ".zip"
  }
}