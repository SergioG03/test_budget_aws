output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "bucket_name" {
  value = aws_s3_bucket.data_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.data_bucket.arn
}

output "iam_user1_arn" {
  description = "ARN del usuario 1"
  value       = module.iam.user1_arn
}

output "iam_user2_arn" {
  description = "ARN del usuario 2"
  value       = module.iam.user2_arn
}
