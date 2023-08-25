# -----------------------------------------------------------
# Set up Delivery channel resource and bucket location to specify configuration history location.
# -----------------------------------------------------------

resource aws_config_delivery_channel this {
  s3_bucket_name = module.bucket.s3_bucket_id
  depends_on     = [aws_config_configuration_recorder.this]
}

