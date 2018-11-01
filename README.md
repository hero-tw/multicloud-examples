https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

## AWS Cluster Deployment
To deploy a configured cluster:

```
cd multicloud-examples
make aws-apply
```

You will be prompted for the name of the new cluster you want to create, and a region (should be us-east-1 or us-west-2), 
and a storage zone (us-east-1a, us-east-1b, us-west-2a, etc).

It will then spin for a while as it applies the configuration. 
At the end you should get the URL for a Jenkins instance.

You can log into the Jenkins instance with:
```
  -user: jenkins
  -password: gqxruzTHJRJDNFiEFQ2XTCRw.
```
## Create-IAM-user
**_Requires [jq](https://stedolan.github.io/jq/download/) to be installed_** 


This script creates an IAM user and stores the access key and id in AWS parameter store. Can be used in any instance that requires a new user to be created.


It creates a new IAM user, generates an access key and stores the access key and access key id in parameter store in the account the aws cli is configured for.

Usage:
```
cd multicloud-examples && cd aws
./create-iam-user.sh [username] [group name]
```
If you don't put a group name or put a group name that doesn't exist, it will default to creating a new user without a group.

