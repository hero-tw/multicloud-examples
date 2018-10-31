.DEFAULT_GOAL := plan

init:
	terraform init && terraform get -update

apply: init
	read -p "Cluster Name: " CLUSTER_NAME; \
	read -p "Region: " REGION; \
	read -p "Storage Region" STORAGE_REGION; \
	echo "Deploying $${CLUSTER_NAME} to $${REGION}"; \
	TF_VAR_app_name=$$CLUSTER_NAME TF_VAR_aws_region=$$REGION TF_VAR_aws_region_storage=$#STORAGE_REGION terraform apply -auto-approve && \
	aws eks update-kubeconfig --name $$CLUSTER_NAME --region=$$REGION && \
	terraform output config-map  | kubectl apply -f -

plan: init
	terraform plan

destroy: init
	terraform destroy --force 

post-setup: 
	helm init && terraform output config-map > config-map.yaml && kubectl apply -f config-map.yaml && rm config-map.yaml
