CONTEXT_PATH ?=
TERRAGRUNT_OPTIONS ?= --terragrunt-debug
GITCONFIG ?= 

all:

.PHONY: gitconfig terragrunt_apply

.SILENT: gitconfig

docker_image: Dockerfile
	docker build -t terraform:latest --network host .

gitconfig:
	@echo "$$GITCONFIG" > ~/.gitconfig

terragrunt_apply: gitconfig
	cd "$(CONTEXT_PATH)/" || exit 1; \
	ls -lah; \
	pwd; \
	terragrunt apply-all --terragrunt-non-interactive $(TERRAGRUNT_OPTIONS) || exit 1