output "bucket_name" {
  description = "Name of the S3 bucket."
  value       = aws_s3_bucket.main.bucket
}
output "daynamodb_table_name" {
  description = "Name of the DynamoDB table."
  value       = aws_dynamodb_table.main.name
}
output "random_id" {
  description = "Random ID generated."
  value = random_id.unique_id.hex
}