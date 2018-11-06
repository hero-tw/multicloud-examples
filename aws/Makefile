.DEFAULT_GOAL := plan

init:
	terraform init \
		-backend-config="bucket=${AWS_BUCKET}"\
		-backend-config="region=${REGION}"\
		&& terraform get -update

apply: init
	echo "Deploying ${ENV_NAME} infra to ${REGION}"; \
	TF_VAR_env_name=${ENV_NAME} TF_VAR_aws_region=${REGION} TF_VAR_aws_region_storage=${REGION}a terraform apply -auto-approve && \
	aws eks update-kubeconfig --name ${ENV_NAME} --region=${REGION} && \
	terraform output config-map  | kubectl apply -f -

plan: init
	terraform plan

destroy: init
	TF_VAR_env_name=${ENV_NAME} TF_VAR_aws_region=${REGION} TF_VAR_aws_region_storage=${REGION} terraform destroy --force
