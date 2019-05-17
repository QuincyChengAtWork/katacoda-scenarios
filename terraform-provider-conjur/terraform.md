
### Preparing Course materials

Let's download the course materials, in case they are not ready in your env:

`curl -fsSL https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/env-init.sh | bash -s`{{execute}}

### Download Terraform

```
apt-get update
apt-get install -y wget unzip
wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
```{{execute}}


### Extract 

```
unzip terraform_0.11.14_linux_amd64.zip
export PATH=$PATH:$(pwd)
```{{execute}}

### Verify Installation

`terraform version`{{execute}}
