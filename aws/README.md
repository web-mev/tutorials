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

This will echo the following upon completion:

- The cloudfront distribution domain which will be used to create a DNS record at your hosting provider:
```
<website_hostname> CNAME <cloudfront_distribution_domain_name>
```
- The IAM access key 
- The protected IAM access secret (displayed as `<sensitive>`). To view the *actual* key, you will then need to run `terraform output iam_user_secret`.

Note that this Terraform plan creates an IAM user with full access to the S3 bucket and to the cloudfront distribution. This is required for GitHub Actions to upload site materials and invalidate the CloudFront cache. You will need the key and secret for GitHub Actions.

At this point you can copy materials to the S3 bucket and they will be available at your domain. Note that site materials as part of this tutorial are created/uploaded via GitHub Actions, but one can always make manual edits.