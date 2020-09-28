
module "gh-repo" {
  source = "./modules/gh-repo"

  for_each = var.repositories

  repo_name = each.value.name 
  repo_description = each.value.description
  repo_license_template = each.value.license
}

