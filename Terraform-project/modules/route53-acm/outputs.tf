output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "alb_certificate_arn" {
  value = aws_acm_certificate.alb_cert.arn
}

output "cloudfront_certificate_arn" {
  value = aws_acm_certificate.cloudfront_cert.arn
}
