.DEFAULT_GOAL := help

AWS_PROFILE=default
PROJECT=eks-hero
PRIMARY_REGION=us-west-1
TF_VAR_aws_region = $PRIMARY_REGION

help:
	cat ./Makefile

# setup terraform bucket for aws
one-time:
	aws s3api create-bucket --bucket "tf-${PROJECT}-${PRIMARY_REGION}" \
	--acl private --profile ${AWS_PROFILE} --region ${PRIMARY_REGION}

aws-apply:
	(cd aws && make apply)
	(cd jenkins && make apply)

aws-destroy:
	(cd aws && make destroy)

gcp-apply:
	(cd gcp && make apply)
	(cd ../jenkins && kubectl apply -f jenkins.yaml)

azu-apply:
	(cd azu && make apply)
	(cd jenkins && kubectl apply -f jenkins.yaml)

all-the-things: aws-apply gcp-apply azu-apply

burn-it-all:
	(cd aws && make destroy) \
	(cd gcp && make destroy) \
	(cd azu && make destroy) 




