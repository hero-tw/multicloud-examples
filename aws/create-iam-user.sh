#!/bin/bash

#apt-get install jq

# Create IAM User
aws iam create-user --user-name "$1" 

#Generate Credentials
aws iam create-access-key --user-name "$1" > test2.txt

#Store Credentials in Param Store
aws ssm put-parameter --name "$1-SECRET-KEY" --type "SecureString" --value $(cat 'test2.txt' | jq '.AccessKey.SecretAccessKey')
aws ssm put-parameter --name "$1-SECRET-ID" --type "SecureString" --value $(cat 'test2.txt' | jq '.AccessKey.AccessKeyId')

#Remove file
rm test2.txt
