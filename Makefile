.DEFAULT_GOAL := help

AWS_PROFILE=default
PROJECT=terraform-poc
PRIMARY_REGION=us-east-1

help:
	cat ./Makefile

# setup terraform bucket for aws
one-time:
	aws s3api create-bucket --bucket "${PROJECT}-infra-${PRIMARY_REGION}" \
	--acl private --profile ${AWS_PROFILE} --region ${PRIMARY_REGION}

aws-apply:
	(cd aws && make apply)

gcp-apply:
	(cd gcp && make apply)

azu-apply:
	(cd azu && make apply)

all-the-things: aws-apply gcp-apply azu-apply

burn-it-all:
	(cd aws && make destroy) \
	(cd gcp && make destroy) \
	(cd azu && make destroy) 



