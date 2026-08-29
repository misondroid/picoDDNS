resource "aws_iam_role" "app" {
  name = "${var.app_name}-${var.app_env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
      {
        Action = "logs:CreateLogGroup"
        Effect = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/lambda/${var.app_name}"
      }
    ]
  })
}

resource "aws_iam_role_policy" "app" {
  name = "${var.app_name}-${var.app_env}"
  role = aws_iam_role.app.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:GetObject"
        Effect = "Allow"
        Resource = "arn:aws:s3:::${data.aws_s3_bucket.management_bucket.id}/*"
      }
    ]
  })
}