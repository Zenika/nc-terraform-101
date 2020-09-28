# LAB 3

## Variables

Jusqu'a présent, nous avons hardcodé nos valeurs. Afin de rendre plus générique notre projet, nous allons variabiliser notre fichier `main.tf`

Dans le fichier `variable.tf`, déclarer les variables suivantes:

```hcl
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
```

Créer un fichier `terraform.tfvars` avec les valeurs souhaitées (remplacer par vos valeurs):

```hcl
  repo_name             = "nc-terraform-example-1"
  repo_description      = "My awesome codebase"
  repo_license_template = "ddadazd"
```

Puis modifier votre `main.tf` afin d'y faire référence:

```hcl
resource "github_repository" "example-1" {
  name             = var.repo_name
  description      = var.repo_description
  visibility       = var.repo_visibility
  has_wiki         = var.repo_has_wiki
  license_template = var.repo_license_template
}
```

Faite un `terraform plan`

La validation de la variable `repo_license_template` ne devrais pas fonctionner car la license fournie n'est pas reconnue.

```hcl
$ terraform plan

Error: Invalid value for variable

  on variables.tf line 34:
  34: variable "repo_license_template" {

The repo_license_template is not a valid license.

This was checked by the validation rule at variables.tf:36,3-13.
```

Modifier votre `terraform.tfvars` pour corriger le problème et vérifier que lors de votre `terraform plan` aucune ressource n'est modifiée.

```hcl
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

github_repository.example-1: Refreshing state... [id=nc-terraform-example-1]
github_branch.develop: Refreshing state... [id=nc-terraform-example-1:develop]
github_repository_file.readme: Refreshing state... [id=nc-terraform-example-1/README.md]

------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

## Templates

Notre `README.md` est toujours statique...

Modifier le fichier `templates/README.md.tmpl` afin d'y ajouter nos variables.

Ajouter la ligne suivante en première ligne:

```hcl
# ${repo_name}
```

Et modifier la dernière ligne (license) en y ajoutant notre variable:

```hcl
[${upper(repo_license)}](LICENSE)
```

Puis dans notre `main.tf` modifier le templatefile pour fournir les valeurs:

```hcl
resource "github_repository_file" "readme" {
  repository = github_repository.example-1.name
  file       = "README.md"
  content    = templatefile("${path.module}/templates/README.md.tmpl",
    {
      repo_name = var.repo_name
      repo_license = var.repo_license_template
    })
}
```