# Terraform Action

This action automates infrastrucuture orchestration providing shared terraform modules and a terragrunt DRY practices boilerplate.  It uses GitHub Actions pipelines to apply infrastructure updates, so you can easily have:

- 1 branch mapping to 1 exclusive private environment
- 1 PR mapping to 1 temporary test environment
- Shared infrastructure in one or more repositories
- Per-service infrastructure in the same repository of the application with minimal impact to developer's project structure
- A real multi-provider experience integrated into the SDLC

This repository is justing cooking some flavorful ingredients: **Terraform, Terragrunt, Docker, GitHub Actions.**

--------------------

**Table of contents**

- [Terraform Action](#terraform-action)
	- [Concept](#concept)
	- [Inputs](#inputs)
		- [`terragrunt_options`](#terragrunt_options)
		- [`path`](#path)
		- [`gitconfig`](#gitconfig)

## Concept

The main goal of the project is to create a NoOps experience with infrastructure orchestration. If a thing is not infrastructure as code (state declaration) it must be infrastructure as automation (state transition trigger).

## Inputs

### `terragrunt_options`

**Required:heavy_exclamation_mark:** Options to pass for *terragrunt* command execution. Default `--terragrunt-debug`.

### `path`

**Required:heavy_exclamation_mark:** Which directory to use as context (current working directory relative to [$GITHUB_WORKSPACE](https://docs.github.com/en/free-pro-team@latest/actions/reference/environment-variables) value). Default `''`.

### `gitconfig`

Optional gitconfig file content, useful for private repository authentication when the terragrunt/terraform module source is a git URI. Default:

```
[url "https://git@github.com"]
    insteadOf = "ssh://git@github.com"
[url "https://YOUR_PERSONAL_ACCESS_TOKEN@github.com"]
    insteadOf = "ssh://private@github.com"
```

**Some considerations about the side effects and requirements of this action:**

1. We don't require **any** terragrunt module project structure, you can specify where to execute `terragrunt apply-all` command using the [path](#path). This path is relative to the root of your repository.
2. To setup credentials you can use the standard authentication method of each terraform provider (as they follow the 12 app factor configuration principle). The workflow of this repository uses GitHub Secrets integration with GitHub Actions to retrieve sensitive values in *"apply time"*.
3. If you want to use the action from other repositories you can't leave the `uses: ./` in the workflow declaration. You must put the pattern: `docker://ghcr.io/metacron/terraform-action:VERSION_TAG` where `VERSION_TAG` substring can be something like `unstable`.
