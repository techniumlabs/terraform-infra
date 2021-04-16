resource "aws_dynamodb_table" "terraform_state_db" {
  name         = "terraform_state"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
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
