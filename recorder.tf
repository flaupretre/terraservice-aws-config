# -----------------------------------------------------------
# set up the AWS Config Recorder
# -----------------------------------------------------------

resource aws_config_configuration_recorder this {
  name     = "config_recorder"
  role_arn = aws_iam_role.this.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

# -----------------------------------------------------------
# Enable AWS Config Recorder
# -----------------------------------------------------------

resource aws_config_configuration_recorder_status this {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.this]
}
