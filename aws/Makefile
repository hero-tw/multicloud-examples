.DEFAULT_GOAL := plan

init:
	read -p "Storage Region: " STORAGE_REGION; \
	read -p "Bucket Name:" AWS_BUCKET; \
	terraform init \
		-backend-config="bucket=$${AWS_BUCKET}"\
		-backend-config="region=$${STORAGE_REGION}"\
		&& terraform get -update

apply: init
	read -p "Cluster Name: " CLUSTER_NAME; \
	read -p "Region: " REGION; \
	read -p "Storage Region: " STORAGE_REGION; \
	echo "Deploying $${CLUSTER_NAME} to $${REGION}"; \
	if terraform workspace select $${CLUSTER_NAME} ; then echo "Workspace selected"; else terraform workspace new $${CLUSTER_NAME}; fi ; \
	TF_VAR_app_name=$$CLUSTER_NAME TF_VAR_aws_region=$$REGION TF_VAR_aws_region_storage=$$STORAGE_REGION terraform apply -auto-approve && \
	aws eks update-kubeconfig --name $$CLUSTER_NAME --region=$$REGION && \
	terraform output config-map  | kubectl apply -f -

plan: init
	terraform plan

destroy: init
	terraform destroy --force
