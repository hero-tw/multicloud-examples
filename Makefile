.DEFAULT_GOAL := help

AWS_PROFILE=default
PROJECT=terraform-porc
PRIMARY_REGION=us-east-1

help:
	cat ./Makefile

# setup terraform bucket
one-time:
	aws s3api create-bucket --bucket "${PROJECT}-infra-${PRIMARY_REGION}" \
	--acl private --profile ${AWS_PROFILE} --region ${PRIMARY_REGION}

aws-apply:
	(cd aws && make apply)

burn-it-all:
	(cd aws && make destroy) 


