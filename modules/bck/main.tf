# Provider
provider "aws" {
  region = var.aws_region
}

# Ramdon ID
resource "random_id" "unique_id" {
  byte_length = 4
}

# Get Account ID
data "aws_caller_identity" "current" {}

# Locals
locals {
  account_id  = data.aws_caller_identity.current.account_id
  unique_id   = random_id.unique_id.hex
  environment = var.environment

  bucket_name_prefix    = "tf-state-${local.environment}-${local.unique_id}"
  dynamodb_table_prefix = "tf-lock-${local.environment}-${local.unique_id}"

  tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "main" {
  bucket = local.bucket_name_prefix
  tags   = local.tags

  lifecycle {
    prevent_destroy = true
  }
}

# Ownership configuration for the Bucket
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.main.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Server Side Encryption configuration for the Bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning configuration for the Bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Dynamodb Table
resource "aws_dynamodb_table" "main" {
  name         = local.dynamodb_table_prefix
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}