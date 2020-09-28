resource "github_repository" "example-1" {
  name             = "nc-terraform-example-1"
  description      = "My awesome codebase"
  visibility       = "private"
  has_wiki         = false
  license_template = "mit"
}

resource "github_branch" "develop" {
  repository = github_repository.example-1.name
  branch     = "develop"
}

resource "github_repository_file" "readme" {
  repository = github_repository.example-1.name
  file       = "README.md"
  content    = templatefile("${path.module}/templates/README.md.tmpl", {})
}


# resource "github_repository" "example-2" {
#   name             = "nc-terraform-to-import"
# }