variable "postgres_password" {
  type    = string
  default = "extrasecretpassword"
}

variable "flask_app_secret" {
  type    = string
  default = "somesuperssecretkeygoeshere"
}

variable "blue_active" {
  type    = bool
  default = true
}

variable "green_active" {
  type    = bool
  default = true
}

variable "blue_tag" {
  type    = string
  default = "v1.3.0"
}

variable "green_tag" {
  type    = string
  default = "v1.3.0"
}
