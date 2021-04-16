resource "aws_security_group" "allow_dns" {
  name        = "allow_dns_to_internal"
  description = "Allow DNS resolve to internal network"
  vpc_id      = var.vpc
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
    },
    var.tags,
  )

}
