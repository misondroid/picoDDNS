# app
resource "aws_lambda_function" "app" {
  function_name     = "${var.app_name}-${var.app_env}"
  s3_bucket         = data.aws_s3_object.app_zip.bucket
  s3_key            = data.aws_s3_object.app_zip.key
  s3_object_version = data.aws_s3_object.app_zip.version_id
  handler           = "app.handler"
  runtime           = "python${var.python_version}"
  role              = aws_iam_role.app.arn
  timeout           = 300
  memory_size       = 1024
  environment {
    variables = {
      LOG_LEVEL = "INFO"
      APP_ENV = var.app_env
      APP_NAME = var.app_name
      CLOUDFLARE_API_TOKEN = var.cloudflare_api_token
      CLOUDFLARE_ACCOUNT_ID = var.cloudflare_account_id
    }
  }
  depends_on = [aws_cloudwatch_log_group.app, aws_cloudwatch_log_stream.app]
}