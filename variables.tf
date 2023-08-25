
variable ctx {
  type = any
}

variable tags {
  type = any
  default = {}
}

variable "encryption_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the resource will have AES256 encryption enabled by default"
}

variable cfg {
  type = any
  default = {}
}

variable retention_days {
  type = number
  default = 0
}
