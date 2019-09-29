resource "aws_s3_bucket" "vault_resources" {
  bucket        = "${var.team_name}-${var.name_prefix}-resources"
  region        = var.region
  force_destroy = true

  acl = "log-delivery-write"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${var.team_name}-${var.name_prefix}-resources"
    target_prefix = "logs/s3_access_logs/"
  }

  lifecycle_rule {
    id      = "vault-logs-s3-lifecycle-rule"
    enabled = true
    prefix  = "logs/"

    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    expiration {
      days = "300"
    }
  }

  lifecycle_rule {
    id      = "vault-resources-s3-lifecycle-rule"
    enabled = true
    prefix  = "resources/"

    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = "7"
    }
  }


  # TODO Replication for s3
  # replication_configuration {
  #   role = aws_iam_role.s3_vault_resources_replicaton_role.arn

  #   rules {
  #     id     = "replicate-vault-resources"
  #     status = "Enabled"
  #     prefix = "resources/"

  #     destination {
  #       bucket        = aws_s3_bucket.vault_resources_dr.arn
  #       storage_class = "STANDARD"
  #     }
  #   }
  # }

  tags = merge(
    {
      "Name"        = "${var.team_name}-${var.name_prefix}-resources"
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )
}

resource "aws_s3_bucket_policy" "vault_resources" {
  bucket = aws_s3_bucket.vault_resources.id
  policy = data.aws_iam_policy_document.s3_vault_resources_bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "vault_resources" {
  bucket = "${aws_s3_bucket.vault_resources.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# resource "aws_s3_bucket" "vault_resources_dr" {
#   provider = "aws.dr"

#   bucket        = "${var.vault_resources_bucket_name}-dr"
#   region        = "${var.dr_region}"
#   force_destroy = true

#   acl = "private"

#   versioning {
#     enabled = true
#   }

#   lifecycle_rule {
#     id      = "vault-resources-s3-lifecycle-rule"
#     enabled = true
#     prefix  = "resources/"

#     abort_incomplete_multipart_upload_days = 7

#     noncurrent_version_expiration {
#       days = "7"
#     }
#   }

#   tags = "${merge(
#     map("Name", "${var.vault_resources_bucket_name}"),
#   var.tags)}"
# }
resource "aws_s3_bucket" "vault_data" {
  bucket        = "${var.team_name}-${var.name_prefix}-data"
  region        = var.region
  force_destroy = true

  acl = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "vault-data-s3-lifecycle-rule"
    enabled = true

    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = "7"
    }
  }

  # replication_configuration {
  #   role = "${aws_iam_role.s3_vault_data_replicaton_role.arn}"

  #   rules {
  #     id     = "replicate-vault-data"
  #     status = "Enabled"
  #     prefix = ""

  #     destination {
  #       bucket        = "${aws_s3_bucket.vault_data_dr.arn}"
  #       storage_class = "STANDARD"
  #     }
  #   }
  # }

  tags = merge(
    {
      "Name"        = "${var.team_name}-${var.name_prefix}-data"
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )
}

resource "aws_s3_bucket_public_access_block" "vault_data" {
  bucket = "${aws_s3_bucket.vault_data.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket" "vault_data_dr" {
#   provider = "aws.dr"

#   bucket        = "${ var.vault_data_bucket_name }-dr"
#   region        = "${ var.dr_region }"
#   force_destroy = true

#   acl = "private"

#   versioning {
#     enabled = true
#   }

#   lifecycle_rule {
#     id      = "vault-data-s3-lifecycle-rule"
#     enabled = true

#     abort_incomplete_multipart_upload_days = 7

#     noncurrent_version_expiration {
#       days = "7"
#     }
#   }

#   tags = "${ merge(
#     map("Name","${ var.vault_data_bucket_name }"),
#     var.tags ) }"
# }
