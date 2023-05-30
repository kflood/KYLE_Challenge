resource "aws_s3_bucket" "challenge_bucket" {
  bucket = var.bucket_name

  tags = var.common_tags
}

resource "aws_s3_bucket_policy" "challenge_bucket_policy" {
  bucket = aws_s3_bucket.challenge_bucket.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [{
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  }
  EOF
}

resource "aws_s3_bucket_acl" "challenge_bucket_acl" {
  bucket = aws_s3_bucket.challenge_bucket.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.challenge_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "challenge_bucket_acl_ownership" {
  bucket = aws_s3_bucket.challenge_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}