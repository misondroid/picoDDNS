resource "aws_cloudwatch_log_group" "app" {
  name = "/aws/lambda/${var.app_name}"
  retention_in_days = 30
}
resource "aws_cloudwatch_log_stream" "app" {
  name = "${var.app_env}"
  log_group_name = aws_cloudwatch_log_group.app.name
}