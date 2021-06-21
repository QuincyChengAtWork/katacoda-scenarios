
### Download Terraform

```
curl -sO https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
```{{execute}}


### Extract 

```
unzip terraform_1.0.0_linux_amd64.zip
export PATH=$PATH:$(pwd)
```{{execute}}

### Verify Installation

`terraform version`{{execute}}
