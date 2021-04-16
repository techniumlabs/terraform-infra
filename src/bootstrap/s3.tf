resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "${var.terraform_state_bucket}"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = merge(
    
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )
}

resource "aws_s3_bucket_public_access_block" "terraform_bucket" {
  bucket = "${aws_s3_bucket.terraform_bucket.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
