# -------------------------
# CloudFront Distribution
# -------------------------

resource "aws_cloudfront_distribution" "cdn" {

  enabled = true

  origins {

    domain_name = var.bucket_name
    origin_id   = "s3-origin"

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  origins {

    domain_name = var.alb_dns
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {

    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {

    path_pattern = "/api/*"

    target_origin_id = "alb-origin"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET","HEAD","OPTIONS","PUT","POST","PATCH","DELETE"]

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_root_object = "index.html"
}
