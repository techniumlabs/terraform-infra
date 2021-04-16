resource "aws_route53_resolver_endpoint" "internal_domain" {
  name      = var.resolver_name
  direction = "OUTBOUND"

  security_group_ids = [
    aws_security_group.allow_dns.id
  ]

  dynamic "ip_address" {
    for_each = tolist(data.aws_subnet_ids.selected.ids)
    content {
      subnet_id = ip_address.value
    }
  }

  tags = merge(
    {
    },
    var.tags,
  )

}

resource "aws_route53_resolver_rule" "forward" {
  domain_name          = var.internal_domain
  name                 = "forward to ${var.resolver_name}"
  rule_type            = "FORWARD"
  resolver_endpoint_id = "${aws_route53_resolver_endpoint.internal_domain.id}"

  dynamic "target_ip" {
    for_each = var.internal_dns_ip
    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    {
    },
    var.tags,
  )
}

resource "aws_route53_resolver_rule_association" "forward" {
  resolver_rule_id = "${aws_route53_resolver_rule.forward.id}"
  vpc_id           = var.vpc
}
