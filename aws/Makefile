.DEFAULT_GOAL := plan

init:
	terraform init && terraform get -update

apply: init
	terraform apply -auto-approve

plan: init
	terraform plan

destroy: init
	terraform destroy --force 

post-setup: 
	helm init && terraform output config-map > config-map.yaml && kubectl apply -f config-map.yaml && rm config-map.yaml
