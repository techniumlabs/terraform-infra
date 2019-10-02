SHELL					:= /bin/bash
WORKING_DIR   := $(shell pwd)

check_defined = \
		$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
		$(if $(value $1),, \
			$(error Undefined $1$(if $2, ($2))))

$(call check_defined, ENV, Environment)


.PHONY: setup plan apply force-apply

setup:: ## Setup Terraform
	@echo "Running Terraform setup"
	$(call check_defined, BUCKET_NAME, Terraform S3 Bucket for state)
	@terraform init -backend-config="bucket=${BUCKET_NAME}"
	@if [[ `terraform workspace list | grep ${ENV}` ]]; then \
	terraform workspace select ${ENV}; else terraform workspace new ${ENV}; fi

plan:: ## Run Terraform plan
	@echo "Running Terraform Plan"
	@terraform plan -var-file ${ENV}.tfvars

apply:: ## Run Terraform apply
	@echo "Running Terraform Apply"
	@terraform apply -var-file ${ENV}.tfvars

force-apply:: ## Run Terraform force apply
	@echo "Running Terraform Apply"
	@terraform apply -var-file ${ENV}.tfvars -auto-approve

# A help target including self-documenting targets (see the awk statement)
help: ## This help target
	@echo ""
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
	{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
