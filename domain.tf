resource "aws_cognito_user_pool_domain" "domain" {
  count  = !var.enabled || var.domain == null || var.domain == "" ? 0 : 1
  domain = "${var.domain_hostname}.${var.domain}"
  # domain = local.user_pool_domain
  certificate_arn = var.domain_certificate_arn
  user_pool_id    = aws_cognito_user_pool.pool[0].id

  # depends_on = [aws_route53_record.dummy]
}

resource "aws_cognito_user_pool_domain" "amz_domain" {
  count        = !var.enabled || var.amz_domain_prefix == null || var.amz_domain_prefix == "" ? 0 : 1
  domain       = var.amz_domain_prefix
  user_pool_id = aws_cognito_user_pool.pool[0].id
}

data "aws_route53_zone" "main" {
  count = var.create_custom_dns_record ? 1 : 0
  name  = "${var.domain}."
}

resource "aws_route53_record" "auth" {
  count   = var.create_custom_dns_record ? 1 : 0
  name    = "${var.domain_hostname}.${var.domain}"
  type    = "A"
  zone_id = data.aws_route53_zone.main[0].zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_cognito_user_pool_domain.domain[0].cloudfront_distribution_arn
    # This zone_id is fixed
    zone_id = "Z2FDTNDATAQYW2"
  }
}

resource "aws_route53_record" "dummy" {
  count   = var.create_custom_dns_record && var.create_dummy_record ? 1 : 0
  name    = var.domain
  type    = "A"
  zone_id = data.aws_route53_zone.main[0].zone_id
  ttl     = "300"
  records = ["1.2.3.4"]
}
