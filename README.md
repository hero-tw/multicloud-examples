https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

## AWS Cluster Deployment
To deploy a configured cluster:

```
cd multicloud-examples
make aws-apply
```

You will be prompted for the name of the new cluster you want to create, and a region (should be us-east-1 or us-west-2).

It will then spin for a while as it applies the configuration. 
At the end you should get the URL for a Jenkins instance.

You can log into the Jenkins instance with:
```
  -user: jenkins
  -password: gqxruzTHJRJDNFiEFQ2XTCRw.
```
## Create-IAM-user
**_Requires [jq](https://stedolan.github.io/jq/download/) to be installed_** 


This script creates an IAM user and stores the access key and id in AWS parameter store. Can be used in any instance that requires a new user to be created

Usage:
```
./create-iam-user.sh [new username]
```


