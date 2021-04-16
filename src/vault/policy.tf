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

data "aws_iam_policy_document" "vault_server_policy" {
  statement {
    sid = ""

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.vault_data.arn}",
      "${aws_s3_bucket.vault_data.arn}/*",
    ]
  }

  statement {
    sid = ""
    actions = [
      "dynamodb:*"
    ]

    resources = [
      "${aws_dynamodb_table.vault_db.arn}"
    ]
  }

  statement {
    sid = ""
    actions = [
      "kms:*"
    ]

    resources = [
      "${aws_kms_key.seal.arn}",
      "${aws_kms_alias.seal.arn}"
    ]
  }

}

resource "aws_iam_policy" "vault_server_policy" {
  name   = "vault_server_policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.vault_server_policy.json}"
}
