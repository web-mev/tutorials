# WebMeV Tutorials

This repository contains static sites for various WebMeV-related tutorials. 

## Instructions

If this is your first time, head to the `aws/` folder and follow the README there. 

The Terraform plan there will set up the various infrastructure elements such as the hosting S3 bucket, CloudFront distribution, and an IAM user. Importantly, it will output provide outputs (e.g. AWS access key/secret, CloudFront distribution ID, etc.) which will be needed for GitHub Actions to deploy the site materials to the hosting bucket.

**Once you have your AWS infrastructure in place...**

Note that you will need the following outputs from Terraform:

- `cloudfront_distribution_id`
- `iam_user_access_key`
- `iam_user_secret` (use `terraform output iam_user_secret` to view the actual secret)

Now, go to the "settings" tab in this repository. On the left side, find the "Secrets and variables" and then the "Actions" category. You will need to add the following "repository secrets". The variable identifiers below correspond to those in the GitHub Actions yaml script. The values are the corresponding outputs from running `terraform apply`. The variable identifiers are not the same, but their associations are obvious.

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_S3_BUCKET_NAME` (not really a secret since it's just the domain name)
- `AWS_CLOUDFRONT_DISTRIBUTION_ID` (note this *is not* the domain that is printed by terraform)