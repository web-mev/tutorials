output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.tutorials_site.domain_name
}

output "iam_user_access_key" {
  value = aws_iam_access_key.tutorial.id
}

output "iam_user_secret" {
  value = aws_iam_access_key.tutorial.secret
  sensitive = true
}