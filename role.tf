# -----------------------------------------------------------
# set up the AWS IAM Role to assign to AWS Config Service
# -----------------------------------------------------------

resource aws_iam_role this {
  name = "config"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/aws-service-role/AWSConfigServiceRolePolicy",
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]

  tags = var.tags
}
