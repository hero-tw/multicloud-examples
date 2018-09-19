.DEFAULT_GOAL := plan

init:
	terraform init && terraform get -update

apply: init
	terraform apply -auto-approve

# plan: init
# 	terraform plan --var-file="../infra/us-east-1-config.tf" --var-file="app.tfvars"

destroy: init
	terraform destroy --force 


