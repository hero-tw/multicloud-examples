#!/bin/bash

#apt-get install jq

# Create IAM User
aws iam create-user --user-name "$1" 

#Add
echo ""
echo "User will be added to Group: $2"
echo ""
aws iam add-user-to-group --user-name "$1" --group-name "$2"
echo ""
echo "User's Groups:"
aws iam list-groups-for-user --user-name "$1"


#Generate Credentials
aws iam create-access-key --user-name "$1" > accesskeyOutput.txt

#Store Credentials in Param Store
aws ssm put-parameter --name "$1-SECRET-KEY" --type "SecureString" --value $(cat 'accesskeyOutput.txt' | jq '.AccessKey.SecretAccessKey')
aws ssm put-parameter --name "$1-SECRET-ID" --type "SecureString" --value $(cat 'accesskeyOutput.txt' | jq '.AccessKey.AccessKeyId')

#Remove file
rm accesskeyOutput.txt

