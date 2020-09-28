resource "github_repository" "example-1" {
  name             = var.repo_name
  description      = var.repo_description
  visibility       = var.repo_visibility
  has_wiki         = var.repo_has_wiki
  license_template = var.repo_license_template
}

resource "github_branch" "develop" {
  repository = github_repository.example-1.name
  branch     = "develop"
}

resource "github_repository_file" "readme" {
  repository = github_repository.example-1.name
  file       = "README.md"
  content    = templatefile("${path.module}/templates/README.md.tmpl", 
    {
      repo_name = var.repo_name
      repo_license = var.repo_license_template
    })
}