
### Download Terraform

```
curl -sO https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
```{{execute}}


### Extract 

```
unzip terraform_0.12.0_linux_amd64.zip
export PATH=$PATH:$(pwd)
```{{execute}}

### Verify Installation

`terraform version`{{execute}}
