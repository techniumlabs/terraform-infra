data "aws_iam_policy_document" "eks_logs_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "eks_logs_policy" {
  name   = "${var.appname}-${var.cluster_name}-logs-policy"
  path   = "/clusterapps/${var.appname}/${var.cluster_name}/"
  policy = data.aws_iam_policy_document.eks_logs_policy.json
}

resource "aws_iam_policy_attachment" "eks_logs" {
  name       = "${var.appname}-${var.cluster_name}-logs-attachment"
  roles      = [module.eks_cluster.worker_iam_role_name]
  policy_arn = aws_iam_policy.eks_logs_policy.arn
}
