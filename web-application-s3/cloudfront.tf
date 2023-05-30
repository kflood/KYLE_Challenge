resource "aws_cloudfront_distribution" "challenge_distribution" {
  origin {
    domain_name              = aws_s3_bucket.challenge_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.challenge_oac.id
    origin_id                = var.bucket_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.bucket_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  tags = var.common_tags

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:771460917126:certificate/83d815f4-5603-4858-a5da-85193f6ab3b4"
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "challenge_oac" {
  name                              = "challenge_oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}