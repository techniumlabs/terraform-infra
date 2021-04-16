resource "aws_kms_alias" "seal" {
  name          = "alias/${var.name_prefix}/seal"
  target_key_id = "${aws_kms_key.seal.key_id}"
}

resource "aws_kms_key" "seal" {
  description = "KMS key used for ${var.name_prefix} seal"

  enable_key_rotation = true

  tags = merge(
    {
      "Name"        = "${var.name_prefix}-seal"
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )

}
