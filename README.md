https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html


To deploy a configured cluster:

```
cd multicloud-examples
make aws-apply
```

You will be prompted for the name of the new cluster you want to create, and a region (should be us-east-1 or us-west-2).

It will then sping for a while as it applies the configuration. At the end you should get the URL for a Jenkins instance.

You can log into the Jenkins instance with user jenkins, password gqxruzTHJRJDNFiEFQ2XTCRw.
