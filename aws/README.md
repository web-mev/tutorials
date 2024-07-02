# Deployment on AWS

## Prerequisites
* Create an HTTPS certificate for your website host name using AWS Certificate Manager in the `us-east-1` region (required by CloudFront)

## Operations

Create and/or edit `terraform.tfvars`:
```shell
cp terraform.tfvars.template terraform.tfvars
```
and add the ARN of the HTTPS certificate and the domain you wish to deploy to (e.g. tutorials.tm4.org)

Deploy the infrastructure:
```shell
terraform apply
```

This will echo the cloudfront distribution domain upon completion. Copy that. Now create a DNS record using that:
```
<website_hostname> CNAME <cloudfront_distribution_domain_name>
```

At this point you can copy materials to the S3 bucket and they will be available at your domain. Note that site materials as part of this tutorial are created/uploaded via GitHub Actions, but one can always make manual edits.