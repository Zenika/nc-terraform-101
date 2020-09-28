
variable "repo_name" {
  type = string
  description = "Your repository name"
}

variable "repo_description" {
  type = string
  description = "Your repository description"
}

variable "repo_visibility" {
  type = string
  description = "Your repository visibility"
  default = "private"
}

variable "repo_has_wiki" {
  type = bool
  default = false
}

variable "repo_license_template" {
  type = string
  validation {
    condition = contains(["mit", "gpl-2.0","apache-2.0"], var.repo_license_template)
    error_message = "The repo_license_template is not a valid license."
  }
}
