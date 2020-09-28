variable "github_token" {
  type = string
  description = "Your personal Github token"
}

variable "github_owner" {
  type = string
  description = "Yout personnal Github account"
}

variable "repositories" {
  type = map(object({
    name           = string
    description    = string
    license        = string
  }))
}

