resource "aws_dynamodb_table" "vault_db" {
  name         = "${var.team_name}-${var.name_prefix}-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "Path"
  range_key = "Key"
  attribute {
    name = "Path"
    type = "S"
  }

  attribute {
    name = "Key"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(
    {
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )
}
