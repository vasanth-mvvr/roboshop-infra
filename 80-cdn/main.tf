resource "aws_cloudfront_distribution" "web_cdn" {
  origin {
    domain_name = "web-${var.environment}.${var.zone_name}"
    origin_id = "web-${var.environment}.${var.zone_name}"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }
  enabled = true
  aliases = ["${var.project_name}-cdn.${var.zone_name}"]

  default_cache_behavior {
    allowed_methods = [ "DELETE", "GET", "PUT", "HEAD", "POST", "OPTIONS", "PATCH" ]
    cached_methods = [ "GET", "HEAD" ]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000

 
    cache_policy_id = data.aws_cloudfront_cache_policy.noCache.id
  }

  ordered_cache_behavior {
    path_pattern = "/images/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.cacheOptimized.id
  }
    ordered_cache_behavior {
    path_pattern = "/static/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project_name}-${var.environment}.${var.zone_name}"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.cacheOptimized.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["US", "IN", "GB", "DE"]     
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_ssm_parameter.aws_acm_certificate_arn.value
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni_only"
  }

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}"
    }
  )
}

module "records" {
  source = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name
  records = [
    {
        name = "roboshop-cdn"
        type = "A"
        allow_overwrite = true
        alias = {
                name = aws_cloudfront_distribution.roboshop.domain_name
                zone_id = aws_cloudfront_distribution.roboshop.hosted_zone_id
        }
        allow_overwrite = true
    }
  ]
}