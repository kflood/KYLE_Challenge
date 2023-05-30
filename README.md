# KYLE_Challenge

## Web Application Challenge

Architecture: This web application is deployed via an s3 bucket, fronted by a CloudFront distribution. This distribution is set to redirect from http to https, and to apply an existing ACM certificate to the site, supporting an alternate domain name. I utilized an existing wildcard cert for the site, but you could create a new cert via IaC if desired, provided you accommodate for domain verification in your pipeline. There is also a route53 record deployed into an existing hosted zone.

By architecting this way instead of a standard ec2 webserver, we have stability and scalability baked in. There could also be significant cost savings depending on site traffic, compared to always-on ec2 hours.

The site is deployed via a Github Actions pipeline. Terraform changes are validated on pull request, with the plan output added to a pull-request comment for review. The terraform apply action is triggered on a merge into the 'main' branch. Additionally, there is an action for the 'site-files' directory sync with the s3 bucket, which is triggered after the terraform apply on merge when the terraform is changed, or on merge when it detects changes to the 'site-files' directory.

## Python Credit Card Problem

This application takes credit card number inputs and validates them. I employed an "is_valid" function to run three validation checks: 
1. does it start with a 4,5 or 6?
2. are there 16 digits, or 4 sets of 4 separated by 3 hyphens? Note: this also checks for valid character usage.
3. are there any digits that repeat 4 times or more?
