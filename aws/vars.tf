variable "https_cert_arn" {
  description = "Identifier for the HTTPS certificate"
  type        = string
}

variable "tutorials_site_hostname" {
  description = "User-facing host name, for example: tutorials.example.org"
  type        = string
}

variable "iam_username" {
  description = "The name of the IAM user to be used by GitHub Actions"
  type        = string
}