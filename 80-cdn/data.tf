data "aws_cloudfront_cache_policy" "cache_enable" {
  name = "ManagedCachingOptimized"
}

data "aws_cloudfront_cache_policy" "cache_disable" {
  name = "ManagedCachingDisabled"
}

data "aws_ssm_parameter" "aws_acm_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/aws_acm_certificate_arn"
}