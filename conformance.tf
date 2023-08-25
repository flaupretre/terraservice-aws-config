# -----------------------------------------------------------
# set up the Conformance Pack
# -----------------------------------------------------------

data "http" "conformance_pack" {
  for_each = { for i in local.packs : i => null }

  url = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/${each.key}.yaml"
}

resource "aws_config_conformance_pack" pack {
  for_each = { for i in local.packs : i => null }

  name          = each.key
  template_body = data.http.conformance_pack[each.key].body

  depends_on = [aws_config_configuration_recorder.this]
}
