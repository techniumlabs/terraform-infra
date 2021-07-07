# Terraform

## Init
This is where you initialize your code to download the requirements mentioned in your code
```bash
/300-s3$ terraform init
```
## Plan
This is where you review changes and choose whether to simply accept them
```bash
/300-s3$ terraform plan --out tfplan.binary
```
## Binary to JSON
This is where convert binary file to json
```bash
/300-s3$ terraform show --json tfplan.binary > plan.json
```
## Evalidate OPA
This is where convert binary file to json
```bash
/300-s3$ opa eval --format pretty --data policy.rego -i plan.json data.terraform.deny
```
## Apply
This is where you accept changes and apply them against real infrastructure
```bash
/300-s3$ terraform apply
```
