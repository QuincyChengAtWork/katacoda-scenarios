
### Download Terraform

```
curl -sO https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
```{{execute}}


### Extract 

```
unzip terraform_0.11.14_linux_amd64.zip
export PATH=$PATH:$(pwd)
```{{execute}}

### Verify Installation

`terraform version`{{execute}}
