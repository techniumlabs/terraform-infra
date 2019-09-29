# The MIT License (MIT)
#
# Copyright (c) 2014-2019 Avant, Sean Lingren

############################
## S3 ######################
############################
# resource "aws_iam_role" "s3_vault_resources_replicaton_role" {
#   name                  = "${var.name_prefix}_s3_resources_replicaton_role"
#   description           = "Role to allow cross region replication from the vault resources s3 bucket"
#   assume_role_policy    = "${data.aws_iam_policy_document.s3_trust_policy.json}"
#   force_detach_policies = true
# }

# resource "aws_iam_role_policy" "s3_vault_resources_replicaton_policy" {
#   name   = "${var.name_prefix}_s3_resources_replicaton_policy"
#   role   = "${aws_iam_role.s3_vault_resources_replicaton_role.id}"
#   policy = "${data.aws_iam_policy_document.s3_vault_resources_replicaton_policy.json}"
# }

# resource "aws_iam_role" "s3_vault_data_replicaton_role" {
#   name                  = "${var.name_prefix}_s3_data_replicaton_role"
#   description           = "Role to allow cross region replication from the vault data s3 bucket"
#   assume_role_policy    = "${data.aws_iam_policy_document.s3_trust_policy.json}"
#   force_detach_policies = true
# }

# resource "aws_iam_role_policy" "s3_vault_data_replicaton_policy" {
#   name   = "${var.name_prefix}_s3_data_replicaton_policy"
#   role   = "${aws_iam_role.s3_vault_data_replicaton_role.id}"
#   policy = "${data.aws_iam_policy_document.s3_vault_data_replicaton_policy.json}"
# }
