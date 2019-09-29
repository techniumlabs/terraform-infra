data "aws_iam_policy_document" "s3_vault_resources_bucket_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.elb_sa.arn}"]
    }

    resources = [
      "${aws_s3_bucket.vault_resources.arn}/logs/alb_access_logs/*",
    ]
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }

    resources = [
      "${aws_s3_bucket.vault_resources.arn}/resources/ssl/*",
      "${aws_s3_bucket.vault_resources.arn}/resources/ssh_key/*",
      "${aws_s3_bucket.vault_resources.arn}/resources/root_key/*",
      "${aws_s3_bucket.vault_resources.arn}/resources/unseal_keys/*",
      "${aws_s3_bucket.vault_resources.arn}/resources/recovery_keys/*",
    ]
  }
}
