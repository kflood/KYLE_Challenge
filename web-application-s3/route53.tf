resource "aws_route53_record" "challenge_r53_entry" {
  zone_id = "Z10085593AEHOCTFMVIKZ"
  name    = var.bucket_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.challenge_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.challenge_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}