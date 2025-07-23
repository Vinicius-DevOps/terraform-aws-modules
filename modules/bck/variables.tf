variable "environment" {
  description = "Name of the environment."
  type        = string
}
variable "aws_region" {
  description = "AWS region for the resources."
  type        = string
}
variable "bucket_name" {
  description = "Name of the S3 bucket."
  type = string
}
variable "dynamodb_name" {
  description = "Name of the DynamoDB table."
  type = string
}