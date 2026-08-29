variable "aws_region" {
  type        = string
  description = "The region of the app"
  default     = "ap-northeast-1"
}
variable "log_retention_in_days" {
  type        = number
  description = "The retention in days for the log group"
  default     = 30
}

variable "aws_account_id" {
  type        = string
  description = "The account id of the app"
  default     = "123456789012"
}
variable "app_lambda_function_name" {
  type        = string
  description = "The name of the app lambda function"
  default     = "picoddns"
}
variable "app_name" {
  type        = string
  description = "The name of the app"
  default     = "picoddns"
}
variable "app_env" {
  type        = string
  description = "The environment of the app"
  default     = "dev"
}
variable "python_version" {
  type        = string
  description = "Python runtime version for Lambda"
  default     = "3.14"
}
variable "management_bucket" {
  type        = string
  description = "The name of the management bucket"
}
variable "log_level" {
  type        = string
  description = "The level of the log"
  default     = "INFO"
}
variable "cloudflare_api_token" {
  type        = string
  description = "The API token for the Cloudflare API"
}
variable "cloudflare_account_id" {
  type        = string
  description = "The account id for the Cloudflare API"
}