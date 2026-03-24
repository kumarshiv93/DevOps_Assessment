output "bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "oac_id" {
  value = aws_cloudfront_origin_access_control.oac.id
}
