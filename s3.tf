# -----------------------------------------------------------
# Create AWS S3 bucket for AWS Config to record configuration history and snapshots
# -----------------------------------------------------------

# Bucket

module bucket {
  source = "git@bitbucket.org:ontexdigitalfactory/terraservice-aws-s3.git//.?ref=v1.8.0"

  bucket_prefix = "config-"
  tags          = var.tags
  versioning    = false
  expiration_days = var.retention_days
}

# -----------------------------------------------------------
# Define AWS S3 bucket policies
# -----------------------------------------------------------

resource "aws_s3_bucket_policy" config {
  bucket = module.bucket.s3_bucket_id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowBucketAcl",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${module.bucket.s3_bucket_arn}",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    },
    {
      "Sid": "AllowConfigWriteAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${module.bucket.s3_bucket_arn}/AWSLogs/${var.ctx.ptf.aws_account_id}/Config/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        },
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    },
    {
      "Sid": "RequireSSL",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:*",
      "Resource": "${module.bucket.s3_bucket_arn}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}
