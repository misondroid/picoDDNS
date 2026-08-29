data "aws_s3_bucket" "management_bucket" {
  bucket = var.management_bucket
}

data "aws_s3_object" "app_zip" {
  bucket = data.aws_s3_bucket.management_bucket.id
  key    = "packages/${var.app_name}-${var.app_env}.zip"
}
