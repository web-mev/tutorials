resource "aws_s3_bucket" "tutorials_site" {
  bucket        = var.tutorials_site_hostname
  force_destroy = true
}

// see https://github.com/hashicorp/terraform-provider-aws/issues/28353
resource "aws_s3_bucket_public_access_block" "tutorials_site" {
  bucket = aws_s3_bucket.tutorials_site.id

  block_public_policy     = false
  restrict_public_buckets = false
  block_public_acls       = false 
  ignore_public_acls      = false 
}

resource "aws_s3_bucket_policy" "tutorials_site" {
  bucket = aws_s3_bucket.tutorials_site.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.tutorials_site.arn,
          "${aws_s3_bucket.tutorials_site.arn}/*",
        ]
      },
    ]
  })
  depends_on = [ aws_s3_bucket_public_access_block.tutorials_site ]
}


resource "aws_cloudfront_distribution" "tutorials_site" {
  aliases             = [var.tutorials_site_hostname]
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  origin {
    domain_name = aws_s3_bucket.tutorials_site.bucket_regional_domain_name
    origin_id   = var.tutorials_site_hostname
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.tutorials_site_hostname
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn      = var.https_cert_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
  # this block allows "direct" urls.
  # Without this, attempts to access {var.tutorials_site_hostname}/foo
  # will generate a 404. By adding this, the angular app will
  # properly load the route associated with /foo
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }
}
