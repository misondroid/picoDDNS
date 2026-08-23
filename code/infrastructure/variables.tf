variable "app_lambda_function_name" {
  type = string
  description = "The name of the app lambda function"
  default = "picoddns"
}
variable "app_env" {
  type = string
  description = "The environment of the app"
  default = "dev"
}
variable "management_bucket" {
  type = string
  description = "The name of the management bucket"
}